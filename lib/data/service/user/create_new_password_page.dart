import 'package:bhw_app/data/service/service_base.dart';

class CreateNewPasswordPage extends ServiceBase {
  final int userId;
  final String password;

  CreateNewPasswordPage({required this.userId, required this.password});

  @override
  Future call() async {
    Map<String, dynamic> body = {
      'userId': userId,
      'newPassword': password,
    };

    return await put('user/updatePassword', body: body);
  }
}
