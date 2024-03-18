import 'package:bhw_app/data/model/user.dart';
import 'package:bhw_app/data/service/service_base.dart';

class AddUserService extends ServiceBase<void> {
  final User user;

  AddUserService({required this.user});

  @override
  Future<Map<String, dynamic>> call() async {
    Map<String, dynamic> body = {
      'projCode': 'BHW',
      'userDetails': {
        'firstName': user.firstName.toLowerCase(),
        'middleName': user.middleName.toLowerCase(),
        'lastName': user.lastName.toLowerCase(),
        'addressLine1': user.addressLine1,
        'addressLine2': user.addressLine2,
        'gender': user.gender,
        'roleUser': user.role,
      }
    };

    var res = await post('user/addUser', body: body);
    var id = res['newUserDetails']['user_id'];

    Map<String, dynamic> bodyFingerPrint = {
      'id': id,
    };

    //post finger print
    postOnly(
      'data',
      body: bodyFingerPrint,
      contentType: 'text/plain',
    );

    return res;
  }
}
