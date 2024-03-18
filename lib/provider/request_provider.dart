import 'package:bhw_app/data/model/user_request.dart';
import 'package:bhw_app/data/service/request/add_request_service.dart';
import 'package:bhw_app/data/service/request/approve_request_service.dart';
import 'package:bhw_app/data/service/request/get_user_request_service.dart';
import 'package:bhw_app/provider/provider_base.dart';

class RequestProvider extends ProviderBase {
  List<UserRequest> requests = [];
  UserRequest? userRequest;

  Future<Map<String, dynamic>> addRequest(UserRequest uReq) async {
    return await AddRequestService(userRequest: uReq).call();
  }

  getUserRequest(int loggedInUserId) async {
    requests = [];
    List<UserRequest> userRequests = await GetUserRequestService().call();

    //Store current ids

    for (var userRequest in userRequests.reversed) {
      if (userRequest.userId == loggedInUserId) {
        requests.add(userRequest);
      }
    }

    notifyListeners();
  }

  getMedecineRequest() async {
    requests = [];
    List<UserRequest> userRequests = await GetUserRequestService().call();
    for (var userRequest in userRequests) {
      if (userRequest.isApprove == null) {
        requests.add(userRequest);
      }
    }
    requests = requests.reversed.toList();
    notifyListeners();
  }

  Future<Map<String, dynamic>> approveRequest(
      {bool isApproved = true, String? explanation}) async {
    return await ApproveRequestService().call(
      id: userRequest!.id!,
      isApproved: isApproved,
      explanation: explanation,
    );
  }
}
