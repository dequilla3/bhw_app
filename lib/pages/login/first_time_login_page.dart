import 'package:bhw_app/components/app_text_field.dart';
import 'package:bhw_app/provider/user_provider.dart';
import 'package:bhw_app/style/btn_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class FirstTimeLoginPage extends StatefulWidget {
  const FirstTimeLoginPage({super.key});

  @override
  State<FirstTimeLoginPage> createState() => _FirstTimeLoginPageState();
}

class _FirstTimeLoginPageState extends State<FirstTimeLoginPage> {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  showAlert(QuickAlertType type, String text, {bool isPop = false}) {
    Future.delayed(Duration.zero, () {
      QuickAlert.show(
        context: context,
        type: type,
        text: text,
        onConfirmBtnTap: () {
          if (isPop) {
            //isPop = pop alert and redirect to prev page
            //pop alert
            Navigator.pop(context);
            //then pop create new password page
            EasyLoading.show(status: "Redirecting to login... \n Please wait!");
            Future.delayed(const Duration(seconds: 1)).then((value) => {
                  Navigator.pop(context),
                  EasyLoading.dismiss(),
                });
          } else {
            //pop alert only
            Navigator.pop(context);
          }
        },
      );
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    final userProvider = context.read<UserProvider>();

    void createNewPassword() {
      if (newPasswordController.text != confirmPasswordController.text) {
        showAlert(
          QuickAlertType.error,
          "Password is incorrect. \n Please confirm your password.",
          isPop: false,
        );
        return;
      }
      EasyLoading.show(status: "Saving new password...");
      userProvider.createNewPassword(newPasswordController.text).then((res) {
        EasyLoading.dismiss();
        if (res['result'] != null) {
          showAlert(
            QuickAlertType.success,
            "Successfully created password!",
            isPop: true,
          );
        }
      }).catchError((onError) {
        EasyLoading.dismiss();
        showAlert(
          QuickAlertType.error,
          "Something went wrong!",
          isPop: false,
        );
        EasyLoading.dismiss();
      });
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
                  'Create new Password!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 24),
                AppTextField(
                  hint: "New Password",
                  controller: newPasswordController,
                  isObscureText: true,
                ),
                const SizedBox(height: 12),
                AppTextField(
                  hint: "Confirm Password",
                  controller: confirmPasswordController,
                  isObscureText: true,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    // } else {
                    onPressed: () {
                      createNewPassword();
                    },
                    style: BtnStyle.primary,
                    child: const Text('Confirm'),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    // } else {
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: BtnStyle.secondary,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.arrowLeftLong,
                          size: 14,
                        ),
                        Text(' Back to login'),
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
