import 'dart:convert';

class UserAddress {
  int? id;
  String name;
  String phone;
  String area;
  String flat;
  String postCode;
  String addressLine1;
  String addressLine2;
  String latitude;
  String longitude;
  String addressName;
  bool isDefault;
  UserAddress({
    this.id,
    required this.name,
    required this.phone,
    required this.area,
    required this.flat,
    required this.postCode,
    required this.addressLine1,
    required this.addressLine2,
    required this.latitude,
    required this.longitude,
    required this.addressName,
    required this.isDefault,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'area': area,
      'flat': flat,
      'post_code': postCode,
      'line_one': addressLine1,
      'line_two': addressLine2,
      'latitude': latitude,
      'longitude': longitude,
      'address_name': addressName,
      'is_default': isDefault,
    };
  }

  factory UserAddress.fromMap(Map<String, dynamic> map) {
    return UserAddress(
      id: map['id'] as int,
      name: map['name'] as String,
      phone: map['phone'] as String,
      area: map['area'] as String,
      flat: map['flat'] as String,
      postCode: map['post_code'].toString(),
      addressLine1: map['line_one'] as String,
      addressLine2: map['line_two'] as String,
      latitude: map['latitude'] ?? '',
      longitude: map['longitude'] ?? '',
      addressName: map['address_name'] as String,
      isDefault: map['is_default'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAddress.fromJson(String source) =>
      UserAddress.fromMap(json.decode(source) as Map<String, dynamic>);
}
