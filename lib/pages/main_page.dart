import 'package:bhw_app/components/toolbar.dart';
import 'package:bhw_app/config/app_routes.dart';
import 'package:bhw_app/pages/request_page.dart';
import 'package:bhw_app/provider/request_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Menus { edit, logout }

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<void> _loadRequest() async {
    context.read<RequestProvider>().getUserRequest();
  }

  @override
  void initState() {
    super.initState();
    _loadRequest();
  }

  int currentPageIndex = 0;

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
            icon: Icon(Icons.swap_vert_circle),
            label: 'Request',
          ),
          NavigationDestination(
            icon: Icon(Icons.approval),
            label: 'Approval',
          ),
          NavigationDestination(
            icon: Icon(Icons.app_registration),
            label: 'Register',
          ),
        ],
      ),
      body: <Widget>[
        const RequestPage(),
        const Center(
          child: Text('approval'),
        ),
        const Center(
          child: Text('register'),
        ),
      ][currentPageIndex],
    );
  }
}
