import 'dart:async';

import 'package:bhw_app/components/app_text_field.dart';
import 'package:bhw_app/components/app_text_field_expandable.dart';
import 'package:bhw_app/config/app_data_context.dart';
import 'package:bhw_app/provider/medicine_provider.dart';
import 'package:bhw_app/provider/request_provider.dart';
import 'package:bhw_app/provider/user_provider.dart';
import 'package:bhw_app/style/app_colors.dart';
import 'package:bhw_app/style/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ApproveRequestPage extends StatefulWidget {
  const ApproveRequestPage({super.key});

  @override
  State<ApproveRequestPage> createState() => _ApproveRequestPageState();
}

class _ApproveRequestPageState extends State<ApproveRequestPage> {
  final tfFocus = FocusNode();
  String? explanation;
  final qtyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tfFocus.requestFocus();
    _loadPendingRequests();
  }

  Future<void> _loadPendingRequests() async {
    return context.read<UserProvider>().getUsers().then((value) async {
      await context.read<MedicineProvider>().getMedicines().then((value) {
        return context.read<RequestProvider>().getMedecineRequest();
      });
    });
  }

  showAlert(QuickAlertType type, String text) {
    Future.delayed(Duration.zero, () {
      QuickAlert.show(
        context: context,
        type: type,
        text: text,
        onConfirmBtnTap: () {
          Navigator.pop(context);
          if (type == QuickAlertType.success) {
            EasyLoading.show(status: "Please wait . . .");
            _loadPendingRequests().then((value) {
              EasyLoading.dismiss();
              Navigator.pop(context);
            });
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<RequestProvider>(context);
    final int itemCode = requestProvider.userRequest!.medRequestId;
    final int? qty = context
        .read<MedicineProvider>()
        .getMedicineByItemCode(requestProvider.userRequest!.medRequestId)
        ?.stockCount;

    bool isStringDigit(String input) {
      // Define the regular expression for a string of digits
      RegExp regExp = RegExp(r'^\d+$');

      // Check if the input matches the regular expression
      return regExp.hasMatch(input);
    }

    Future<void> approveRequest() async {
      if (qtyController.text.isEmpty) {
        showAlert(QuickAlertType.error, "Qty is required!");
        return;
      }

      int qtyDispense = int.parse(qtyController.text);

      if (!isStringDigit(qtyController.text)) {
        showAlert(QuickAlertType.error, "Qty must be number!");
        return;
      }

      if (qtyDispense > (qty ?? 0)) {
        showAlert(QuickAlertType.error, "Not enough quantity!");
        return;
      }

      await Future.delayed(Duration.zero, () {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.confirm,
          text: (qty ?? 0) < 10
              ? "Qty is less than 10. You want to approve this request?"
              : "You want to approve this request?",
          onConfirmBtnTap: () async {
            Navigator.pop(context);
            EasyLoading.show(status: "Sending approval...");
            await requestProvider
                .approveRequest(
                    isApproved: true, explanation: explanation ?? "")
                .then((value) {
              EasyLoading.dismiss();
              if (value['errorMsg'] != null) {
                showAlert(QuickAlertType.error, value['errorMsg']);
                return;
              }
              EasyLoading.show(status: "Updating stocks. . .");
              context
                  .read<MedicineProvider>()
                  .updateMeds(itemCode, (qty ?? 0) - qtyDispense)
                  .then((value) {
                EasyLoading.dismiss();
                showAlert(QuickAlertType.success, "Request approved!");
              });
            });
          },
        );
      });
    }

    rejectRequest() {
      Future.delayed(Duration.zero, () {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.confirm,
          text: "You want to reject this request?",
          onConfirmBtnTap: () {
            Navigator.pop(context);
            EasyLoading.show(status: "Sending rejection...");
            requestProvider
                .approveRequest(isApproved: false, explanation: explanation)
                .then((value) {
              EasyLoading.dismiss();
              showAlert(QuickAlertType.success, "Request Rejected!");
              return;
            });
          },
        );
      });
    }

    Widget renderRequestBadge(isEmerg) {
      return Padding(
        padding: const EdgeInsets.only(left: 16, top: 16),
        child: Container(
          decoration: BoxDecoration(
            color: isEmerg ? Colors.red : Colors.green,
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              isEmerg ? 'EMERGENCY REQUEST' : 'NORMAL REQUEST',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () => tfFocus.unfocus(),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 36,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const FaIcon(
                            FontAwesomeIcons.arrowLeft,
                            size: 18,
                          ),
                        ),
                      ),
                      const Text(
                        " For Approval",
                        style: AppText.header3,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: renderRequestBadge(
                    requestProvider.userRequest!.requestType == "EMERGENCY"),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${AppDataContext.getMedicines()[itemCode].toString().split("-")[1]} ",
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            "QTY ON HAND: ",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "$qty",
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "REASON: ",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            requestProvider.userRequest!.reasonRequest,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        hint: "Enter Qty",
                        controller: qtyController,
                        focusNode: tfFocus,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
                child: AppTextFieldExpandable(
                  maxLines: 5,
                  hint: 'Write explanation...',
                  onChange: (value) {
                    setState(() {
                      explanation = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    await approveRequest();
                  },
                  child: const SizedBox(
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Approve! '),
                          FaIcon(
                            FontAwesomeIcons.thumbsUp,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.danger.withOpacity(0.8),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    rejectRequest();
                  },
                  child: const SizedBox(
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Reject! '),
                          FaIcon(
                            FontAwesomeIcons.thumbsDown,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
