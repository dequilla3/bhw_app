import 'package:bhw_app/data/model/user_request.dart';
import 'package:bhw_app/data/service/user_request_service.dart';
import 'package:flutter/material.dart';

class RequestProvider extends ChangeNotifier {
  List<UserRequest> requests = [];
  UserRequest? userRequest;

  addRequest(UserRequest uReq) {
    requests.add(uReq);
    notifyListeners();
  }

  getUserRequest() async {
    List<UserRequest> requestsFromStore =
        await UserRequestService().getReuestFromLocalStorell();
    requests.addAll(requestsFromStore);

    notifyListeners();
  }
}
