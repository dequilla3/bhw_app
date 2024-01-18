import 'package:bhw_app/pages/login_page.dart';
import 'package:bhw_app/pages/main_page.dart';
import 'package:bhw_app/pages/request/request_details_screen.dart';
import 'package:bhw_app/pages/request/request_page.dart';
import 'package:bhw_app/pages/user/add_user_page.dart';

class AppRoutes {
  static const loginPage = '/';
  static const mainPage = '/main_page';
  static const requestPage = '/request_page';
  static const requestDetailsRoute = '/request_details_screen';
  static const addUserPage = '/add_user_page';

  static final routes = {
    loginPage: (contex) => const LoginPage(),
    mainPage: (context) => const MainPage(),
    requestPage: (context) => const RequestPage(),
    addUserPage: (context) => const AddUserPage(),
    requestDetailsRoute: (context) => const RequestDetailsScreen(),
  };
}
