import 'package:bhw_app/data/model/user_request.dart';
import 'package:bhw_app/data/service/request/user_request_service.dart';
import 'package:bhw_app/provider/provider_base.dart';

class RequestProvider extends ProviderBase {
  List<UserRequest> requests = [];
  UserRequest? userRequest;

  addRequest(UserRequest uReq) async {
    requests.insert(0, uReq);
    // gets new id
    final docId = db.collection('requests').doc().id;
// save the item
    await db.collection('requests').doc(docId).set({
      'id': uReq.id,
      'details': uReq.details,
      'isEmergency': uReq.isEmergency,
      'status': uReq.status,
      'dateCreated': uReq.dateCreated.toString()
    });
    notifyListeners();
  }

  getUserRequest() async {
    requests = [];
    List<UserRequest> requestsFromStore =
        await UserRequestService().getReuestFromLocalStore();
    requests.addAll(requestsFromStore.reversed.toList());
    notifyListeners();
  }
}
