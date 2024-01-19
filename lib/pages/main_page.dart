import 'package:bhw_app/components/toolbar.dart';
import 'package:bhw_app/config/app_routes.dart';
import 'package:bhw_app/pages/user/user_page.dart';
import 'package:bhw_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

enum Menus { edit, logout }

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPageIndex = 0;

  Future<void> loadUser() async {
    context.read<UserProvider>().getUsers();
  }

  @override
  void initState() {
    super.initState();

    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolBar(
        title: 'B H W',
        actions: [
          PopupMenuButton<Menus>(
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
                        child: Icon(
                          Icons.logout,
                          color: Colors.black,
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
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        // indicatorColor: AppColors.primary,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.thumbsUp,
              size: 20,
            ),
            label: 'Approval',
          ),
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.userPlus,
              size: 20,
            ),
            label: 'Register',
          ),
        ],
      ),
      body: <Widget>[
        const Center(
          child: Text('approval'),
        ),
        const UserPage(),
      ][currentPageIndex],
    );
  }
}
