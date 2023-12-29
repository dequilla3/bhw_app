import 'package:bhw_app/style/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextFieldExpandable extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChange;
  final FocusNode? focusNode;
  final int? maxLines;
  final int? minLines;
  const AppTextFieldExpandable({
    super.key,
    this.hint,
    this.controller,
    this.onChange,
    this.focusNode,
    this.maxLines,
    this.minLines,
  });

  @override
  Widget build(Object context) {
    return TextField(
      maxLines: maxLines,
      minLines: minLines,
      style: const TextStyle(fontSize: 12),
      onChanged: onChange,
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black54, fontSize: 12),
        fillColor: AppColors.bgLight,
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.white),
        ),
        filled: true,
      ),
    );
  }
}
