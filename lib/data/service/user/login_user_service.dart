import 'package:bhw_app/data/service/service_base.dart';

class LoginUserService extends ServiceBase<void> {
  final String username;
  final String password;

  LoginUserService({required this.username, required this.password});

  @override
  Future<Map<String, dynamic>> call() async {
    Map<String, dynamic> body = {
      'userName': username,
      'userPassword': password,
    };

    return await post('user/authenticate', body: body);
  }
}
