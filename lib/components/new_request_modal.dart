import 'package:bhw_app/components/app_text_field_expandable.dart';
import 'package:bhw_app/data/model/user_request.dart';
import 'package:bhw_app/provider/request_provider.dart';
import 'package:bhw_app/style/app_colors.dart';
import 'package:bhw_app/style/app_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class NewRequestModal extends StatefulWidget {
  const NewRequestModal({super.key});

  @override
  State<NewRequestModal> createState() => _NewRequestModalState();
}

class _NewRequestModalState extends State<NewRequestModal> {
  final tfFocus = FocusNode();

  bool isChecked = false;
  String requestDetails = "";

  @override
  Widget build(BuildContext context) {
    const uuid = Uuid();
    final requestProiver = Provider.of<RequestProvider>(context);

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
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Request',
                        style: AppText.header3,
                      ),
                      const Spacer(),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.primary.withOpacity(0.2),
                          // padding: const EdgeInsets.only(left: 20, right: 20),
                        ),
                        onPressed: () {
                          tfFocus.unfocus();
                          UserRequest userRequest = UserRequest(
                              uuid.v1(),
                              requestDetails,
                              isChecked,
                              'PENDING',
                              DateTime.now());

                          requestProiver.addRequest(userRequest);

                          Navigator.pop(context);
                        },
                        child: const Text('Create'),
                      ),
                    ],
                  ),
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
                  AppTextFieldExpandable(
                    maxLines: 5,
                    hint: 'Write symptoms...',
                    focusNode: tfFocus,
                    onChange: (value) {
                      setState(() {
                        requestDetails = value;
                      });
                    },
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
