import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

class HiveCartModel {
  int id;
  int shopId;
  String name;
  String productImage;
  double price;
  double oldPrice;
  int productsQTY;
  HiveCartModel({
    required this.id,
    required this.shopId,
    required this.name,
    required this.productImage,
    required this.price,
    required this.oldPrice,
    required this.productsQTY,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'shopId': shopId,
      'name': name,
      'productImage': productImage,
      'price': price,
      'old_price': oldPrice,
      'productsQTY': productsQTY,
    };
  }

  factory HiveCartModel.fromMap(Map<dynamic, dynamic> map) {
    return HiveCartModel(
      id: map['id'] as int,
      shopId: map['shopId'] as int,
      name: map['name'] as String,
      productImage: map['productImage'] as String,
      price: map['price'] as double,
      oldPrice: map['old_price'] as double,
      productsQTY: map['productsQTY'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory HiveCartModel.fromJson(String source) =>
      HiveCartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class HiveCartModelAdapter extends TypeAdapter<HiveCartModel> {
  @override
  final typeId = 0;

  @override
  HiveCartModel read(BinaryReader reader) {
    return HiveCartModel.fromMap(reader.readMap());
  }

  @override
  void write(BinaryWriter writer, HiveCartModel obj) {
    writer.writeMap(obj.toMap());
  }
}
