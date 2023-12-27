import 'package:bhw_app/components/app_text_field_expandable.dart';
import 'package:bhw_app/controller/request_controller.dart';
import 'package:bhw_app/style/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewRequestModal extends StatefulWidget {
  const NewRequestModal({super.key});

  @override
  State<NewRequestModal> createState() => _NewRequestModalState();
}

class _NewRequestModalState extends State<NewRequestModal> {
  final tfFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    RequestController requestController = Get.find();

    var height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => tfFocus.unfocus(),
      child: Container(
        height: height * 0.75,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(
              children: [
                const Text(
                  'Add Request',
                  style: AppText.header3,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                )
              ],
            ),
            AppTextFieldExpandable(
              maxLines: 5,
              hint: 'Write symptoms...',
              focusNode: tfFocus,
              onChange: (value) {},
            ),
            Checkbox(
              checkColor: Colors.white,
              value: requestController.isChecked.value,
              onChanged: (bool? value) {
                requestController.toggleCheckbox();
              },
            ),
          ]),
        ),
      ),
    );
  }
}
