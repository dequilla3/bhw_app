import 'package:bhw_app/data/model/user_request.dart';
import 'package:bhw_app/data/service/service_base.dart';

class GetUserRequestService extends ServiceBase<List<UserRequest>> {
  final String? token;

  GetUserRequestService({this.token});

  @override
  Future<List<UserRequest>> call() async {
    final result = await get('request/getAllRequest', token);
    return List.generate(
      result['data'] != null ? result['data'].length : 0,
      (index) {
        return UserRequest.fromJson(result['data'][index]);
      },
    );
  }
}
