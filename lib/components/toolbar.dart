import 'package:bhw_app/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ToolBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  const ToolBar({super.key, this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      foregroundColor: Colors.black,
      title: Row(
        children: [
          const FaIcon(
            FontAwesomeIcons.capsules,
            size: 22,
            color: AppColors.font2,
          ),
          const SizedBox(width: 8),
          Text(
            title ?? "",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
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
