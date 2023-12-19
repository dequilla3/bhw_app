import 'package:bhw_app/components/app_text_field.dart';
import 'package:bhw_app/style/app_colors.dart';
import 'package:flutter/material.dart';

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
  var _isLoading = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                SizedBox(height: height * 0.10),
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
                SizedBox(height: height * 0.05),
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
                    onPressed: () {
                      // doLogin();
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
