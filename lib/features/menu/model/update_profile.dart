import 'dart:convert';

class UpdateProfile {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  UpdateProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });

  UpdateProfile copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
  }) {
    return UpdateProfile(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
    };
  }

  factory UpdateProfile.fromMap(Map<String, dynamic> map) {
    return UpdateProfile(
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateProfile.fromJson(String source) =>
      UpdateProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UpdateProfile(first_name: $firstName, last_name: $lastName, email: $email, phone: $phone)';
  }

  @override
  bool operator ==(covariant UpdateProfile other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.phone == phone;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        phone.hashCode;
  }
}
