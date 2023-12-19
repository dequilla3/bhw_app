import 'package:bhw_app/style/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChange;
  final bool isObscureText;
  final FocusNode? focusNode;
  final int? maxLines;
  const AppTextField(
      {super.key,
      this.hint,
      this.controller,
      this.onChange,
      this.isObscureText = false,
      this.focusNode,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.08,
      child: TextField(
        style: const TextStyle(fontSize: 14),
        obscureText: isObscureText,
        onChanged: onChange,
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          isDense: true,
          labelText: hint,
          labelStyle: const TextStyle(color: AppColors.font2, fontSize: 14),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primary.withOpacity(0.4),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primary,
            ),
          ),
          filled: true,
        ),
      ),
    );
  }
}
