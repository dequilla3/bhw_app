import 'package:bhw_app/components/toolbar.dart';
import 'package:bhw_app/config/app_routes.dart';
import 'package:bhw_app/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DefaultToolBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultToolBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolBar(
        title: 'B H W',
        actions: [
          PopupMenuButton<Menus>(
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: FaIcon(FontAwesomeIcons.circleUser),
            ),
            onSelected: (value) {
              Navigator.of(context).pushReplacementNamed(AppRoutes.loginPage);
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: Menus.logout,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: FaIcon(
                          FontAwesomeIcons.powerOff,
                          size: 16,
                        ),
                      ),
                      Text('Log out')
                    ],
                  ),
                ),
              ];
            },
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
