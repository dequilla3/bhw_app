import 'package:bhw_app/components/toolbar.dart';
import 'package:bhw_app/config/app_routes.dart';
import 'package:bhw_app/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DefaultToolBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultToolBar({super.key, this.title, tis, this.userName});
  final String? title;
  final String? userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolBar(
        title: title ?? 'B H C',
        actions: [
          PopupMenuButton<Menus>(
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: FaIcon(FontAwesomeIcons.circleUser),
            ),
            onSelected: (value) {
              if (value == Menus.logout) {
                Navigator.of(context).pushReplacementNamed(AppRoutes.loginPage);
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: Menus.user,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: FaIcon(
                          FontAwesomeIcons.user,
                          size: 16,
                        ),
                      ),
                      Text(userName!)
                    ],
                  ),
                ),
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
