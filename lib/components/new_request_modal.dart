import 'package:bhw_app/components/app_text_field_expandable.dart';
import 'package:bhw_app/data/model/user_request.dart';
import 'package:bhw_app/provider/request_provider.dart';
import 'package:bhw_app/style/app_colors.dart';
import 'package:bhw_app/style/app_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewRequestModal extends StatefulWidget {
  const NewRequestModal({super.key});

  @override
  State<NewRequestModal> createState() => _NewRequestModalState();
}

class _NewRequestModalState extends State<NewRequestModal> {
  final tfFocus = FocusNode();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final appRepo = Provider.of<RequestProvider>(context);
    String requestDetails = "";

    return GestureDetector(
      onTap: () => tfFocus.unfocus(),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Add Request',
                    style: AppText.header3,
                  ),
                  const Spacer(),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primary.withOpacity(0.2),
                      // padding: const EdgeInsets.only(left: 20, right: 20),
                    ),
                    onPressed: () {
                      appRepo.addRequest(
                          UserRequest(1, requestDetails, isChecked, 'PENDING'));
                      Navigator.pop(context);
                    },
                    child: const Text('Create'),
                  ),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  const Text(
                    'Emergency ?',
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
                  requestDetails = value;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
