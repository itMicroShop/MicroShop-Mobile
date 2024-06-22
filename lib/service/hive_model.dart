import 'dart:convert';

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String name;
  final String? email;
  final String phone;
  final String profilePhoto;
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.email,
    required this.phone,
    required this.profilePhoto,
  });

  User copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? name,
    String? email,
    String? phone,
    String? profilePhoto,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'name': name,
      'email': email,
      'phone': phone,
      'thumbnail': profilePhoto,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'].toInt() as int,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      name: map['name'] as String,
      email: map['email'] ?? '',
      phone: map['phone'] as String,
      profilePhoto: map['thumbnail'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, first_name: $firstName, last_name: $lastName, name: $name, email: $email, phone: $phone)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.name == name &&
        other.email == email &&
        other.phone == phone;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode;
  }
}
