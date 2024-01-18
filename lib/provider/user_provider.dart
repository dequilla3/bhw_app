import 'package:bhw_app/data/model/user.dart';
import 'package:bhw_app/data/service/user/add_user_service.dart';
import 'package:bhw_app/data/service/user/get_user_service.dart';
import 'package:bhw_app/provider/provider_base.dart';

class UserProvider extends ProviderBase {
  final List<User> users = [];

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
}
