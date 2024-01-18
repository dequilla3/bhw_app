import 'package:bhw_app/components/app_text_field.dart';
import 'package:bhw_app/components/toolbar.dart';
import 'package:bhw_app/config/app_routes.dart';
import 'package:bhw_app/data/model/user.dart';
import 'package:bhw_app/provider/user_provider.dart';
import 'package:bhw_app/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

enum Gender { none, male, female, others }

enum Role { admin, user, none }

class _AddUserPageState extends State<AddUserPage> {
  var gender = Gender.none;
  var role = Role.none;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();

  Future<void> loadUser() async {
    await context.read<UserProvider>().getUsers();
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
    final postProvider = context.read<UserProvider>();
    addUser() {
      User user = User(
        firstName: firstNameController.text,
        middleName: middleNameController.text,
        lastName: lastNameController.text,
        addressLine1: address1Controller.text,
        addressLine2: address2Controller.text,
        gender: gender.name,
        role: role.name,
      );

      postProvider.addUser(user).then(
        (res) {
          if (res["errorMsg"] != null) {
            Future.delayed(const Duration(seconds: 1), () {
              showAlert(
                QuickAlertType.error,
                res["errorMsg"],
                isPop: false,
              );
            });
          } else {
            Future.delayed(const Duration(seconds: 1), () {
              showAlert(
                QuickAlertType.success,
                "Successfully added user!",
                isPop: true,
              );
              loadUser();
            });
          }
        },
      );
    }

    return Scaffold(
      appBar: const ToolBar(
        title: 'ADD USER',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            AppTextField(
              hint: "First Name",
              controller: firstNameController,
            ),
            const SizedBox(
              height: 8,
            ),
            AppTextField(
              hint: "Middle Name",
              controller: middleNameController,
            ),
            const SizedBox(
              height: 8,
            ),
            AppTextField(
              hint: "Last Name",
              controller: lastNameController,
            ),
            const SizedBox(
              height: 8,
            ),
            AppTextField(
              hint: "Address Line 1",
              controller: address1Controller,
            ),
            const SizedBox(
              height: 8,
            ),
            AppTextField(
              hint: "Address Line 2",
              controller: address2Controller,
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.only(left: 12, top: 6, right: 12),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gender',
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                            visualDensity: const VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity),
                            contentPadding: EdgeInsets.zero,
                            title: const Text(
                              'Male',
                              style: TextStyle(fontSize: 13),
                            ),
                            value: Gender.male,
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = Gender.male;
                              });
                            }),
                      ),
                      Expanded(
                        child: RadioListTile(
                            visualDensity: const VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity),
                            contentPadding: EdgeInsets.zero,
                            title: const Text(
                              'Female',
                              style: TextStyle(fontSize: 13),
                            ),
                            value: Gender.female,
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = Gender.female;
                              });
                            }),
                      ),
                      Expanded(
                        child: RadioListTile(
                            visualDensity: const VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity),
                            contentPadding: EdgeInsets.zero,
                            title: const Text(
                              'Others',
                              style: TextStyle(fontSize: 13),
                            ),
                            value: Gender.others,
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = Gender.others;
                              });
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.only(left: 12, top: 6, right: 12),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Role',
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                            visualDensity: const VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity),
                            contentPadding: EdgeInsets.zero,
                            title: const Text(
                              'Admin',
                              style: TextStyle(fontSize: 13),
                            ),
                            value: Role.admin,
                            groupValue: role,
                            onChanged: (value) {
                              setState(() {
                                role = Role.admin;
                              });
                            }),
                      ),
                      Expanded(
                        child: RadioListTile(
                            visualDensity: const VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity),
                            contentPadding: EdgeInsets.zero,
                            title: const Text(
                              'User',
                              style: TextStyle(fontSize: 13),
                            ),
                            value: Role.user,
                            groupValue: role,
                            onChanged: (value) {
                              setState(() {
                                role = Role.user;
                              });
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primary.withOpacity(0.2),
                // padding: const EdgeInsets.only(left: 20, right: 20),
              ),
              onPressed: () {
                addUser();
              },
              child: const SizedBox(
                width: double.infinity,
                child:
                    Align(alignment: Alignment.center, child: Text('Create')),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
