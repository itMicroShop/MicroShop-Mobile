import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SignUpCredential {
  String firstName;
  String lastName;
  String? email;
  String phoneNumber;
  String password;
  String confirmPassword;
  SignUpCredential({
    required this.firstName,
    required this.lastName,
    this.email,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
  });


  SignUpCredential copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? password,
    String? confirmPassword,
  }) {
    return SignUpCredential(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phoneNumber,
      'password': password,
      'password_confirmation': confirmPassword,
    };
  }

  factory SignUpCredential.fromMap(Map<String, dynamic> map) {
    return SignUpCredential(
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      email: map['email'] != null ? map['email'] as String : null,
      phoneNumber: map['phone'] as String,
      password: map['password'] as String,
      confirmPassword: map['password_confirmation'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpCredential.fromJson(String source) => SignUpCredential.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SignUpCredential(first_name: $firstName, last_name: $lastName, email: $email, phone: $phoneNumber, password: $password, password_confirmation: $confirmPassword)';
  }

  @override
  bool operator ==(covariant SignUpCredential other) {
    if (identical(this, other)) return true;
  
    return 
      other.firstName == firstName &&
      other.lastName == lastName &&
      other.email == email &&
      other.phoneNumber == phoneNumber &&
      other.password == password &&
      other.confirmPassword == confirmPassword;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
      lastName.hashCode ^
      email.hashCode ^
      phoneNumber.hashCode ^
      password.hashCode ^
      confirmPassword.hashCode;
  }
}
