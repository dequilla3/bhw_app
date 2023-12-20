class UserRequest {
  final int id;
  final String details;
  final bool isEmergency;
  final bool isApproved;

  UserRequest(this.id, this.details, this.isEmergency, this.isApproved);

  factory UserRequest.fromJson(Map<String, dynamic> json) => UserRequest(
      json['id'], json['details'], json['isEmergency'], json['isApproved']);
}
