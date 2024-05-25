class UserRequest {
  final int? id;
  final int userId;
  final String requestType;
  final String reasonRequest;
  final int medRequestId;
  final bool? isApprove;
  final String? dateRequest;

  UserRequest({
    this.id,
    required this.userId,
    required this.requestType,
    required this.reasonRequest,
    required this.medRequestId,
    this.isApprove,
    this.dateRequest,
  });

  factory UserRequest.fromJson(Map<String, dynamic> json) => UserRequest(
      id: json['request_id'],
      userId: int.parse(json['user_id']),
      requestType: json['request_type'],
      reasonRequest: json['reason_request'],
      medRequestId: int.parse(json['med_request']),
      isApprove: json['is_approved'],
      dateRequest: json['date_request']);
}
