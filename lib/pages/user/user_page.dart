import 'dart:math' as math;

import 'package:bhw_app/config/app_routes.dart';
import 'package:bhw_app/data/model/user.dart';
import 'package:bhw_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  ScrollController? scrollController;
  Future<void> loadUser() async {
    context.read<UserProvider>().getUsers();
  }

  void scrollListener() {
    if (scrollController!.position.extentAfter < 500) {
      loadUser();
    }
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  void dispose() {
    scrollController?.removeListener(scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color getRandomColor() {
      return Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0);
    }

    FaIcon getGenderIcon(String gender) {
      return FaIcon(
        gender.toLowerCase() == "male"
            ? FontAwesomeIcons.person
            : FontAwesomeIcons.personDress,
        size: 11,
      );
    }

    Widget getRoleIcon(String role) {
      return Column(
        children: [
          FaIcon(
            role.toLowerCase() == "admin"
                ? FontAwesomeIcons.userShield
                : FontAwesomeIcons.user,
            size: 14,
          ),
          Text(
            role == "admin" ? "ADMIN" : "USER",
            style: const TextStyle(fontSize: 8),
          ),
        ],
      );
    }

    return RefreshIndicator(
      onRefresh: () {
        return loadUser();
      },
      child: Consumer<UserProvider>(
        builder: (context, value, child) {
          return Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                        controller: scrollController,
                        itemCount: value.users.length,
                        itemBuilder: (context, index) {
                          User user = value.users[index];

                          return ListTile(
                            onTap: () {},
                            leading: CircleAvatar(
                              foregroundColor: Colors.white,
                              backgroundColor: getRandomColor(),
                              child: Text(user.firstName[0].toUpperCase()),
                            ),
                            isThreeLine: true,
                            title: Text(
                              "${user.firstName} ${user.lastName}"
                                  .toUpperCase(),
                            ),
                            subtitle: Text(
                              "${user.addressLine1}, ${user.addressLine2}",
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: getRoleIcon(user.role),
                            ),
                          );
                        }),
                  ),
                ],
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.addUserPage);
                    },
                    child: const FaIcon(FontAwesomeIcons.plus)),
              )
            ],
          );
        },
      ),
    );
  }
}
