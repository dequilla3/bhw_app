import 'package:bhw_app/components/app_text_field.dart';
import 'package:bhw_app/config/app_routes.dart';
import 'package:bhw_app/provider/user_provider.dart';
import 'package:bhw_app/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final focusUserName = FocusNode();
  final focusPassword = FocusNode();
  final _isLoading = false;

  showAlert(QuickAlertType type, String text, {bool isPop = false}) {
    Future.delayed(Duration.zero, () {
      QuickAlert.show(
        context: context,
        type: type,
        text: text,
        onConfirmBtnTap: () {
          if (isPop) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.mainPage);
          } else {
            Navigator.pop(context);
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    final userProvider = context.read<UserProvider>();

    bool isValid() {
      if (usernameController.text == "") {
        showAlert(
          QuickAlertType.error,
          "Username is required!",
          isPop: false,
        );
        return false;
      }
      if (passwordController.text == "") {
        showAlert(
          QuickAlertType.error,
          "Password is required!",
          isPop: false,
        );
        return false;
      }
      return true;
    }

    auth() {
      if (!isValid()) return;
      EasyLoading.show(status: 'Loggin In...');

      userProvider.auth(usernameController.text, passwordController.text).then(
        (res) {
          EasyLoading.dismiss();
          focusUserName.unfocus();
          focusPassword.unfocus();
          if (res['authData'] != null) {
            if (res['authData']['role_user'] == 'admin') {
              Navigator.of(context).pushReplacementNamed(AppRoutes.mainPage);
            } else {
              Navigator.of(context).pushReplacementNamed(AppRoutes.requestPage);
            }
          } else {
            if (res['msg'] != null) {
              showAlert(
                QuickAlertType.error,
                res['msg'],
                isPop: false,
              );
            } else {
              showAlert(
                QuickAlertType.error,
                "Something went wrong!",
                isPop: false,
              );
            }
          }
        },
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                const Spacer(),
                Container(
                  height: height * 0.20,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                      image: AssetImage("assets/img/bg-min.png"),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                const Text(
                  'Hello, Welcome!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 24),
                AppTextField(
                  hint: "Username",
                  controller: usernameController,
                  focusNode: focusUserName,
                ),
                const SizedBox(height: 12),
                AppTextField(
                  hint: "Password",
                  controller: passwordController,
                  isObscureText: true,
                  focusNode: focusPassword,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    // } else {
                    onPressed: () {
                      auth();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Login'),
                        const SizedBox(width: 8),
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: _isLoading
                              ? const CircularProgressIndicator()
                              : const SizedBox(),
                        )
                      ],
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
