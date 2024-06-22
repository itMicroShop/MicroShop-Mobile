import 'dart:convert';

import 'package:grocerymart/features/checkout/model/order.dart';

class OrderDetails {
  final Order order;
  final ShippingAddress shippingAddress;
  final List<OrderProduct> products;
  OrderDetails({
    required this.order,
    required this.shippingAddress,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'order': order.toMap(),
      'shippingAddress': shippingAddress.toMap(),
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderDetails.fromMap(Map<String, dynamic> map) {
    return OrderDetails(
      order: Order.fromMap(map['order'] as Map<String, dynamic>),
      shippingAddress:
          ShippingAddress.fromMap(map['shipping'] as Map<String, dynamic>),
      products: List<OrderProduct>.from(
        (map['products'] as List<dynamic>).map<OrderProduct>(
          (x) => OrderProduct.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetails.fromJson(String source) =>
      OrderDetails.fromMap(json.decode(source) as Map<String, dynamic>);
}

class OrderProduct {
  final int id;
  final String name;
  final String thumbnail;
  final double price;
  final int quantity;
  OrderProduct({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.price,
    required this.quantity,
  });

  OrderProduct copyWith({
    int? id,
    String? name,
    String? thumbnail,
    double? price,
    int? quantity,
  }) {
    return OrderProduct(
      id: id ?? this.id,
      name: name ?? this.name,
      thumbnail: thumbnail ?? this.thumbnail,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'thumbnail': thumbnail,
      'price': price,
      'quantity': quantity,
    };
  }

  factory OrderProduct.fromMap(Map<String, dynamic> map) {
    return OrderProduct(
      id: map['id'],
      name: map['name'] as String,
      thumbnail: map['thumbnail'] as String,
      price: double.tryParse(map['price']) ?? 0.0,
      quantity: int.parse(map['quantity']),
    );
  }
}

class ShippingAddress {
  final String postCode;
  final String lineOne;
  final String lineTwo;
  final String latitude;
  final String longitude;
  final String name;
  final String phone;
  final String area;
  final String flat;
  final String addressName;
  final String country;
  final String state;
  ShippingAddress({
    required this.postCode,
    required this.lineOne,
    required this.lineTwo,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.phone,
    required this.area,
    required this.flat,
    required this.addressName,
    required this.country,
    required this.state,
  });

  ShippingAddress copyWith({
    String? postCode,
    String? lineOne,
    String? lineTwo,
    String? latitude,
    String? longitude,
    String? name,
    String? phone,
    String? area,
    String? flat,
    String? addressName,
    String? country,
    String? state,
  }) {
    return ShippingAddress(
      postCode: postCode ?? this.postCode,
      lineOne: lineOne ?? this.lineOne,
      lineTwo: lineTwo ?? this.lineTwo,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      area: area ?? this.area,
      flat: flat ?? this.flat,
      addressName: addressName ?? this.addressName,
      country: country ?? this.country,
      state: state ?? this.state,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'post_code': postCode,
      'line_one': lineOne,
      'line_two': lineTwo,
      'latitude': latitude,
      'longitude': longitude,
      'name': name,
      'phone': phone,
      'area': area,
      'flat': flat,
      'address_name': addressName,
      'country': country,
      'state': state,
    };
  }

  factory ShippingAddress.fromMap(Map<String, dynamic> map) {
    return ShippingAddress(
      postCode: map['post_code'] as String,
      lineOne: map['line_one'] as String,
      lineTwo: map['line_two'] as String,
      latitude: map['latitude'] ?? '',
      longitude: map['longitude'] ?? '',
      name: map['name'] as String,
      phone: map['phone'] as String,
      area: map['area'] ?? 'Area Not Found',
      flat: map['flat'] ?? 'Flat Not Found',
      addressName: map['address_name'] ?? '',
      country: map['country'] ?? '',
      state: map['state'] ?? '',
    );
  }
}
