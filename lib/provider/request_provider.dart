import 'package:bhw_app/data/model/user.dart';
import 'package:bhw_app/data/model/user_request.dart';
import 'package:bhw_app/data/service/request/add_request_service.dart';
import 'package:bhw_app/data/service/request/approve_request_service.dart';
import 'package:bhw_app/data/service/request/get_user_request_service.dart';
import 'package:bhw_app/provider/provider_base.dart';

class RequestProvider extends ProviderBase {
  List<UserRequest> requests = [];
  List<UserRequest> filteredRequests = [];
  UserRequest? userRequest;

  Future<Map<String, dynamic>> addRequest(UserRequest uReq) async {
    return await AddRequestService(userRequest: uReq).call();
  }

  getUserRequest(int loggedInUserId, String? fstatus) async {
    requests = [];
    filteredRequests = [];
    List<UserRequest> userRequests = await GetUserRequestService().call();

    //Store current ids

    for (var userRequest in userRequests.reversed) {
      if (userRequest.userId == loggedInUserId) {
        String status = userRequest.isApprove == null
            ? "PENDING"
            : userRequest.isApprove!
                ? "APPROVED"
                : "REJECTED";
        if (status == fstatus) {
          filteredRequests.add(userRequest);
        }
        requests.add(userRequest);
      }
    }

    notifyListeners();
  }

  getMedecineRequest(String? fstatus) async {
    requests = [];
    filteredRequests = [];

    List<UserRequest> userRequests = await GetUserRequestService().call();
    for (var userRequest in userRequests) {
      requests.add(userRequest);
      String status = userRequest.isApprove == null
          ? "PENDING"
          : userRequest.isApprove!
              ? "APPROVED"
              : "REJECTED";
      if (status == fstatus) {
        filteredRequests.add(userRequest);
      }
    }
    notifyListeners();
  }

  filterRequest(String s, List<User> users, String filteredStatus,
      int? loggedInUserId, bool isAdmin) {
    filteredRequests = [];

    List<String> matchingUserIds =
        users.map((user) => user.id.toString()).toList();

    for (var req in requests) {
      String status = req.isApprove == null
          ? "PENDING"
          : req.isApprove!
              ? "APPROVED"
              : "REJECTED";

      if (s.isEmpty && status == filteredStatus && isAdmin) {
        filteredRequests.add(req);
        notifyListeners();

        continue;
      }

      if (status == filteredStatus) {
        if (matchingUserIds.contains(req.userId.toString())) {
          if (!isAdmin) {
            if (loggedInUserId != null && req.userId == loggedInUserId) {
              filteredRequests.add(req);
            }
            notifyListeners();

            continue;
          }
          filteredRequests.add(req);
        }
        notifyListeners();
      }
    }
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
