import 'package:bhw_app/style/app_colors.dart';
import 'package:flutter/material.dart';

class BtnStyle {
  static ButtonStyle primary = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
  );

  static ButtonStyle danger = ElevatedButton.styleFrom(
    backgroundColor: AppColors.danger,
    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
  );

  static ButtonStyle secondary = ElevatedButton.styleFrom(
    backgroundColor: AppColors.secondary,
    foregroundColor: Colors.black54,
  );
}
