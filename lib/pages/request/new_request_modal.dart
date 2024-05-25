import 'package:bhw_app/components/app_text_field_expandable.dart';
import 'package:bhw_app/config/app_data_context.dart';
import 'package:bhw_app/data/model/user_request.dart';
import 'package:bhw_app/provider/medicine_provider.dart';
import 'package:bhw_app/provider/request_provider.dart';
import 'package:bhw_app/provider/user_provider.dart';
import 'package:bhw_app/style/app_text.dart';
import 'package:bhw_app/style/btn_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class NewRequestModal extends StatefulWidget {
  const NewRequestModal({super.key});

  @override
  State<NewRequestModal> createState() => _NewRequestModalState();
}

class _NewRequestModalState extends State<NewRequestModal> {
  final tfFocus = FocusNode();
  bool isChecked = false;
  String reason = "";
  List<int> list = <int>[1, 2, 3, 4, 5];
  int dropdownValue = 1;

  Future<void> _loadRequest() async {
    context.read<RequestProvider>().getUserRequest(
        context.read<UserProvider>().loggedInUserId!, "PENDING");
  }

  showAlert(QuickAlertType type, String text, {bool isPop = false}) {
    Future.delayed(Duration.zero, () {
      QuickAlert.show(
        context: context,
        type: type,
        text: text,
        onConfirmBtnTap: () {
          if (isPop) {
            Navigator.pop(context);
            _loadRequest().then((value) => Navigator.pop(context));
          } else {
            Navigator.pop(context);
          }
        },
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final requestProiver = Provider.of<RequestProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    addRequest() async {
      tfFocus.unfocus();

      context.read<MedicineProvider>().getMedicines().then((value) {
        if (context
                .read<MedicineProvider>()
                .getMedicineByItemCode(dropdownValue)
                ?.stockCount ==
            0) {
          showAlert(
            QuickAlertType.error,
            "Not enough quantity!",
          );
          return;
        }

        UserRequest userRequest = UserRequest(
          userId: userProvider.loggedInUserId!,
          requestType: isChecked ? "EMERGENCY" : "NORMAL",
          reasonRequest: reason,
          medRequestId: dropdownValue,
        );

        EasyLoading.show(status: "Saving new request...");
        try {
          requestProiver.addRequest(userRequest).then((value) {
            if (value["message"].toString().contains("Limit")) {
              EasyLoading.dismiss();
              showAlert(
                QuickAlertType.error,
                value["message"],
                isPop: true,
              );
              return;
            }
            EasyLoading.dismiss();
            Future.delayed(const Duration(seconds: 0), () {
              //loadRequest in showAlert
              showAlert(
                QuickAlertType.success,
                "Request successfully sent!",
                isPop: true,
              );
            });
          });
        } catch (err) {
          showAlert(
            QuickAlertType.error,
            "Something went wrong!",
            isPop: true,
          );
          EasyLoading.dismiss();
        }
      });
    }

    return GestureDetector(
      onTap: () {
        tfFocus.unfocus();
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 18,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
                const Text(
                  'Request',
                  style: AppText.header3,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Emergency?',
                        style: TextStyle(fontSize: 14),
                      ),
                      Checkbox(
                        checkColor: Colors.white,
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: DropdownMenu<int>(
                      initialSelection: list.first,
                      onSelected: (int? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      dropdownMenuEntries:
                          list.map<DropdownMenuEntry<int>>((int value) {
                        return DropdownMenuEntry<int>(
                          value: value,
                          label: AppDataContext.getMedicines()[value]
                              .toString()
                              .split("-")[1],
                        );
                      }).toList(),
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 8),
                  AppTextFieldExpandable(
                    maxLines: 5,
                    hint: 'Write reason...',
                    focusNode: tfFocus,
                    onChange: (value) {
                      setState(() {
                        reason = value;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      // } else {
                      onPressed: () {
                        addRequest();
                      },
                      style: BtnStyle.primary,
                      child: const Text('Create Request'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
