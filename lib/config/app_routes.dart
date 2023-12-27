import 'package:bhw_app/view/pages/login_page.dart';
import 'package:bhw_app/view/pages/main_page.dart';
import 'package:bhw_app/view/screens/request_details_screen.dart';

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
