class UserRequest {
  final String id;
  final String details;
  final bool isEmergency;
  final String status;
  final DateTime dateCreated;

  UserRequest(
      this.id, this.details, this.isEmergency, this.status, this.dateCreated);

  factory UserRequest.fromJson(Map<String, dynamic> json) => UserRequest(
      json['id'],
      json['details'],
      json['isEmergency'],
      json['status'],
      DateTime.parse(json['dateCreated']));
}
