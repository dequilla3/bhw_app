import 'package:bhw_app/data/service/service_base.dart';

class ApproveRequestService extends ServiceBase<void> {
  @override
  Future<Map<String, dynamic>> call(
      {int? id, bool isApproved = true, String? explanation}) async {
    Map<String, dynamic> body = {
      'isApproved': isApproved,
      'explanation': explanation,
    };
    return await put('request/approvalRequest/$id', body: body);
  }
}
