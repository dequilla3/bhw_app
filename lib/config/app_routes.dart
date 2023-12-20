import 'package:bhw_app/view/login_page.dart';
import 'package:bhw_app/view/main_page.dart';

class AppRoutes {
  static const loginPage = '/';
  static const mainPage = '/main_page';

  static final pages = {
    loginPage: (contex) => const LoginPage(),
    mainPage: (context) => const MainPage(),
  };
}
