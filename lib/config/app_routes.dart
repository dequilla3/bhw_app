import 'package:bhw_app/pages/login_page.dart';
import 'package:bhw_app/pages/main_page.dart';
import 'package:bhw_app/pages/request_details_screen.dart';

class AppRoutes {
  static const loginPage = '/';
  static const mainPage = '/main_page';
  static const requestDetailsRoute = '/request_details_screen';

  static final routes = {
    loginPage: (contex) => const LoginPage(),
    mainPage: (context) => const MainPage(),
    requestDetailsRoute: (context) => const RequestDetailsScreen(),
  };
}
