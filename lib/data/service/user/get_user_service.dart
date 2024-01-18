import 'package:bhw_app/data/model/user.dart';
import 'package:bhw_app/data/service/service_base.dart';

class GetUserService extends ServiceBase<List<User>> {
  final String? token;

  GetUserService({this.token});

  @override
  Future<List<User>> call() async {
    final result = await get('user/getAllUser/bhw', token);
    return List.generate(
      result['data'] != null ? result['data'].length : 0,
      (index) {
        return User.fromJson(result['data'][index]);
      },
    );
  }
}
