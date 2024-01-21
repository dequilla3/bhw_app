import 'package:bhw_app/data/model/user_request.dart';
import 'package:bhw_app/data/service/service_base.dart';

class AddRequestService extends ServiceBase<void> {
  final UserRequest userRequest;

  AddRequestService({required this.userRequest});

  @override
  Future<Map<String, dynamic>> call() async {
    Map<String, dynamic> body = {
      'userId': userRequest.userId,
      'requestType': userRequest.requestType,
      'reasonRequest': userRequest.reasonRequest,
      'medRequest': userRequest.medRequestId,
    };
    return await post('request/createRequest', body: body);
  }
}
