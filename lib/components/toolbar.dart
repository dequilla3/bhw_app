import 'package:bhw_app/style/app_colors.dart';
import 'package:flutter/material.dart';

class ToolBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  const ToolBar({super.key, this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.bgLight,
      foregroundColor: Colors.black,
      title: Row(
        children: [
          const Icon(
            Icons.medication_rounded,
            size: 36,
            color: AppColors.font2,
          ),
          Text(
            title ?? "",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.font2,
            ),
          ),
        ],
      ),
      centerTitle: false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
