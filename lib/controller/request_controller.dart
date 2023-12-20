import 'package:bhw_app/model/user_request.dart';
import 'package:get/get.dart';

class RequestController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    loadRequest();
    print('TEST123');
  }

  @override
  void dispose() {
    super.dispose();
  }

  late List<UserRequest> requests;

  loadRequest() {
    requests = [
      UserRequest(
        1,
        "Body temperatures vary slightly from person to person and at different times of day. The average temperature has traditionally been defined as 98.6 F (37 C). A temperature taken using a mouth thermometer (oral temperature) that's 100 F (37.8 C) or higher is generally considered to be a fever.",
        true,
        false,
      ),
      UserRequest(
        2,
        "Body temperatures vary slightly from person to person and at different times of day. The average temperature has traditionally been defined as 98.6 F (37 C). A temperature taken using a mouth thermometer (oral temperature) that's 100 F (37.8 C) or higher is generally considered to be a fever.",
        true,
        false,
      ),
      UserRequest(
        2,
        "Body temperatures vary slightly from person to person and at different times of day. The average temperature has traditionally been defined as 98.6 F (37 C). A temperature taken using a mouth thermometer (oral temperature) that's 100 F (37.8 C) or higher is generally considered to be a fever.",
        false,
        false,
      ),
    ];
    update();
  }
}
