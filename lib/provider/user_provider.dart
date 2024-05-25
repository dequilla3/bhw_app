import 'package:bhw_app/data/model/user.dart';
import 'package:bhw_app/data/service/user/add_user_service.dart';
import 'package:bhw_app/data/service/user/create_new_password_page.dart';
import 'package:bhw_app/data/service/user/get_user_service.dart';
import 'package:bhw_app/data/service/user/login_user_service.dart';
import 'package:bhw_app/provider/provider_base.dart';

class UserProvider extends ProviderBase {
  List<User> users = [];
  User? loggedUser;
  int? loggedInUserId;
  String? userName;

  Future<List<User>> getUsers() async {
    var res = await GetUserService().call();
    users = [];
    users.addAll(res);

    loggedUser = getLoggedUser();

    notifyListeners();

    return res;
  }

  List<User> filterUserByName(String s) {
    return users.where((user) {
      // Check if the user's first name or last name contains the search string
      return user.firstName.toLowerCase().contains(s.toLowerCase()) ||
          user.lastName.toLowerCase().contains(s.toLowerCase());
    }).toList();
  }

  User getUserById(id) {
    return users.firstWhere((element) => element.id == id);
  }

  User getLoggedUser() {
    return users.firstWhere((element) => element.id == loggedInUserId);
  }

  Future<Map<String, dynamic>> addUser(User user) async {
    return await AddUserService(user: user).call();
  }

  Future<Map<String, dynamic>> auth(String username, String password) async {
    Map<String, dynamic> res =
        await LoginUserService(username: username, password: password).call();

    if (res['authData'] != null) {
      loggedInUserId = int.parse(res['authData']['user_id']);
      userName = res['authData']['user_name'].toString();
    }

    return res;
  }

  Future<Map<String, dynamic>> createNewPassword(String password) async {
    return await CreateNewPasswordPage(
            userId: loggedInUserId!, password: password)
        .call();
  }
}
