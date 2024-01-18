import 'package:bhw_app/data/model/user.dart';
import 'package:bhw_app/data/model/user_request.dart';
import 'package:bhw_app/data/service/service_base.dart';

class UserRequestService extends ServiceBase<User> {
  Future<List<UserRequest>> getReuestFromLocalStore() async {
    List<UserRequest> reqs = [];

    final result = await getLocalStoreCollections('requests');

    if (result == null) {
      return reqs;
    }

    for (var key in result.keys) {
      reqs.add(UserRequest.fromJson(result[key]));
    }

    return reqs;
  }

  @override
  Future<User> call() {
    throw UnimplementedError();
  }
}
