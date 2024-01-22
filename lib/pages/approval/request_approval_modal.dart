import 'package:bhw_app/components/app_text_field_expandable.dart';
import 'package:bhw_app/config/app_data_context.dart';
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

class RequestApprovalModal extends StatefulWidget {
  const RequestApprovalModal({super.key});

  @override
  State<RequestApprovalModal> createState() => _RequestApprovalModalState();
}

class _RequestApprovalModalState extends State<RequestApprovalModal> {
  final tfFocus = FocusNode();
  String? explanation;

  @override
  void initState() {
    super.initState();
    tfFocus.requestFocus();
  }

  Future<void> _loadPendingRequests() async {
    return context
        .read<UserProvider>()
        .getUsers()
        .then((value) => context.read<RequestProvider>().getPendingRequest());
  }

  showAlert(QuickAlertType type, String text) {
    Future.delayed(Duration.zero, () {
      QuickAlert.show(
        context: context,
        type: type,
        text: text,
        onConfirmBtnTap: () {
          Navigator.pop(context);
          _loadPendingRequests().then((value) => Navigator.pop(context));
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<RequestProvider>(context);

    approveRequest() {
      Future.delayed(Duration.zero, () {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.confirm,
          text: "You want to approve this request?",
          onConfirmBtnTap: () {
            Navigator.pop(context);
            EasyLoading.show(status: "Sending approval...");
            requestProvider
                .approveRequest(isApproved: true, explanation: explanation)
                .then((value) {
              EasyLoading.dismiss();
              showAlert(QuickAlertType.success, "Request approved!");
              return;
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

    return GestureDetector(
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
                      "${AppDataContext.getMedicines()[requestProvider.userRequest!.medRequestId]}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      requestProvider.userRequest!.reasonRequest,
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
                focusNode: tfFocus,
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
                onPressed: () {
                  approveRequest();
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
    );
  }
}
