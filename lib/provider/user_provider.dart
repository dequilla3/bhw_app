import 'package:bhw_app/data/model/user.dart';
import 'package:bhw_app/data/service/user/add_user_service.dart';
import 'package:bhw_app/data/service/user/create_new_password_page.dart';
import 'package:bhw_app/data/service/user/get_user_service.dart';
import 'package:bhw_app/data/service/user/login_user_service.dart';
import 'package:bhw_app/provider/provider_base.dart';

class UserProvider extends ProviderBase {
  final List<User> users = [];

  int? loggedInUserId;

  getUsers() async {
    List<User> posts = await GetUserService().call();
    List<int> curIds = [];

    //Store current ids
    for (var user in users) {
      curIds.add(user.id!);
    }

    for (var post in posts) {
      if (!curIds.contains(post.id)) {
        users.add(post);
      }
    }
    notifyListeners();
  }

  Future<Map<String, dynamic>> addUser(User user) async {
    return await AddUserService(user: user).call();
  }

  Future<Map<String, dynamic>> auth(String username, String password) async {
    Map<String, dynamic> res =
        await LoginUserService(username: username, password: password).call();

    if (res['authData'] != null) {
      loggedInUserId = int.parse(res['authData']['user_id']);
    }

    return res;
  }

  Future<Map<String, dynamic>> createNewPassword(String password) async {
    return await CreateNewPasswordPage(
            userId: loggedInUserId!, password: password)
        .call();
  }
}
