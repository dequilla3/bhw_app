class User {
  final int? id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String addressLine1;
  final String addressLine2;
  final String gender;
  final String role;

  User(
      {this.id,
      required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.addressLine1,
      required this.addressLine2,
      required this.gender,
      required this.role});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: int.parse(json['user_id']),
        firstName: json['first_name'],
        middleName: json['middle_name'],
        lastName: json['last_name'],
        addressLine1: json['address_line1'],
        addressLine2: json['address_line2'],
        gender: json['gender'],
        role: json['role_user'],
      );
}
