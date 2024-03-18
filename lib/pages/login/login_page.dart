import 'package:bhw_app/components/app_text_field.dart';
import 'package:bhw_app/config/app_url.dart';
import 'package:bhw_app/config/app_routes.dart';
import 'package:bhw_app/provider/user_provider.dart';
import 'package:bhw_app/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:localstore/localstore.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final db = Localstore.instance;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final serverIpController = TextEditingController();
  final serverDeviceIpController = TextEditingController();

  final _focusUserName = FocusNode();
  final _focusPassword = FocusNode();

  @override
  void initState() {
    super.initState();
    // Initialization tasks can be performed here
    print('initState called');
    loadIps();
  }

  void loadIps() async {
    EasyLoading.show(status: "Initializing . . .");

    final items = await db.collection('ips').get();
    if (items != null) {
      var baseIp = items['/ips/ips']['baseIp'];
      var deviceIp = items['/ips/ips']['deviceIp'];
      serverIpController.text = baseIp;
      serverDeviceIpController.text = deviceIp;

      AppUrl.setBaseUrl(baseIp);
      AppUrl.setDeviceUrl(deviceIp);
    }

    EasyLoading.dismiss();
  }

  Widget modalServer() {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          )),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 12),
            const Text(
              "Setup Server",
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 24),
            AppTextField(
              hint: "Base URL Server IP",
              controller: serverIpController,
            ),
            const SizedBox(height: 12),
            AppTextField(
              hint: "Base URL Server Device IP",
              controller: serverDeviceIpController,
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    EasyLoading.show(status: "Saving IP's . . .");

                    await db.collection('ips').doc("ips").set({
                      'baseIp': serverIpController.text,
                      'deviceIp': serverDeviceIpController.text
                    });

                    showAlertModal(
                      QuickAlertType.success,
                      "Successfully saved ip.",
                      isPop: true,
                    );

                    EasyLoading.dismiss();
                  } catch (e) {
                    print(e);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }

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

  showAlertModal(QuickAlertType type, String text, {bool isPop = false}) {
    Future.delayed(Duration.zero, () {
      QuickAlert.show(
        context: context,
        type: type,
        text: text,
        onConfirmBtnTap: () {
          if (isPop) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.loginPage);
          }
        },
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
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

    bool hasError(Map<String, dynamic> res) {
      if (res['errorMsg'] != null) {
        showAlert(
          QuickAlertType.error,
          res['errorMsg'],
          isPop: false,
        );
        return true;
      }

      if (res['authData'] == null) {
        showAlert(
          QuickAlertType.error,
          res['msg'],
          isPop: false,
        );
        return true;
      }

      return false;
    }

    void authentication() async {
      try {
        if (!isValid()) return;
        EasyLoading.show(status: 'Loggin In...');

        //calling api starts here
        await userProvider
            .auth(usernameController.text, passwordController.text)
            .then(
          (res) {
            EasyLoading.dismiss();
            if (hasError(res)) return;

            _focusUserName.unfocus();
            _focusPassword.unfocus();

            if (usernameController.text == passwordController.text) {
              Navigator.of(context).pushNamed(AppRoutes.firstTimeLoginPage);
            } else if (res['authData']['role_user'] == 'admin') {
              Navigator.of(context).pushReplacementNamed(AppRoutes.mainPage);
            } else {
              Navigator.of(context).pushReplacementNamed(AppRoutes.requestPage);
            }
          },
        );
      } catch (err) {
        //catch any error
        print(err);
        showAlert(
          QuickAlertType.error,
          "Something went wrong!",
          isPop: false,
        );
        EasyLoading.dismiss();
      }
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
                  focusNode: _focusUserName,
                ),
                const SizedBox(height: 12),
                AppTextField(
                  hint: "Password",
                  controller: passwordController,
                  isObscureText: true,
                  focusNode: _focusPassword,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    // } else {
                    onPressed: () {
                      authentication();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    // } else {
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          // Return a container with your content
                          return modalServer();
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.bgLight,
                      foregroundColor: AppColors.black,
                    ),
                    child: const Text('Server'),
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
