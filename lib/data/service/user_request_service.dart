import 'package:bhw_app/data/model/user_request.dart';
import 'package:bhw_app/data/service/service_base.dart';

class UserRequestService extends ServiceBase {
  Future<List<UserRequest>> getReuestFromLocalStorell() async {
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
}
