import 'package:bhw_app/components/default_toolbar.dart';
import 'package:bhw_app/pages/approval/request_approval_page.dart';
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
      appBar: const DefaultToolBar(),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: NavigationBar(
          backgroundColor: Colors.transparent,
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
                FontAwesomeIcons.userPlus,
                size: 18,
              ),
              label: 'Register',
            ),
            NavigationDestination(
              icon: FaIcon(
                FontAwesomeIcons.thumbsUp,
                size: 18,
              ),
              label: 'Approval',
            ),
          ],
        ),
      ),
      body: <Widget>[
        const UserPage(),
        const RequestApprovalPage(),
      ][currentPageIndex],
    );
  }
}
