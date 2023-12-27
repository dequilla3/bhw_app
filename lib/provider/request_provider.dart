import 'package:bhw_app/data/model/user_request.dart';
import 'package:flutter/material.dart';

class RequestProvider extends ChangeNotifier {
  List<UserRequest> requests = [];
  UserRequest? userRequest;

  addRequest(UserRequest uReq) {
    requests.add(uReq);
    notifyListeners();
  }
}
