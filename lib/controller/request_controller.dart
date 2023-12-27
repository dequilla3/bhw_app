import 'package:bhw_app/model/user_request.dart';
import 'package:get/get.dart';

class RequestController extends GetxController {
  late UserRequest userRequest;
  late List<UserRequest> requests;
  // var isChecked = false.obs;

  var isChecked = false.obs;

  void toggleCheckbox() {
    isChecked.value = isChecked.value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    loadRequest();
  }

  @override
  void dispose() {
    super.dispose();
    requests = [];
  }

  void onChangeCheckBox() {
    isChecked(!isChecked.value);
    update();
  }

  UserRequest getUserRequest() => userRequest;
  void setUserRequest(UserRequest userReq) => userRequest = userReq;

  loadRequest() {
    requests = [
      UserRequest(
        1,
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        true,
        'APPROVED',
      ),
      UserRequest(
        2,
        "Lorem ipsum dolor sit amet. Qui quia enim non voluptatem aliquid et voluptas mollitia ut velit aspernatur quo eveniet debitis? Id sapiente voluptatem 33 sunt consequatur et fuga dolor ut maxime laudantium.",
        true,
        'APPROVED',
      ),
      UserRequest(
        2,
        "Hic quaerat praesentium eos iure accusantium qui saepe placeat id iusto rerum? Est rerum vitae et natus autem ea ipsam velit vel iusto eius vel voluptas cupiditate aut debitis repudiandae id consequatur perspiciatis.",
        false,
        'PENDING',
      ),
      UserRequest(
        2,
        "Body temperatures vary slightly from person to person and at different times of day. The average temperature has traditionally been defined as 98.6 F (37 C). A temperature taken using a mouth thermometer (oral temperature) that's 100 F (37.8 C) or higher is generally considered to be a fever.",
        false,
        'REJECTED',
      ),
    ];
    update();
  }
}
