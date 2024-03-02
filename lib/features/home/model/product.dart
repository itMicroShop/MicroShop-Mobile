import 'dart:convert';

class Product {
  final int id;
  final String name;
  final String? description;
  final String thumbnail;
  final double price;
  final double oldPrice;
  final String discountPercentage;
  final int shopId;
  final String shopName;
  final String sellType;
  final int minimumQuantity;
  final bool inStock;
  Product({
    required this.id,
    required this.name,
    this.description,
    required this.thumbnail,
    required this.price,
    required this.oldPrice,
    required this.discountPercentage,
    required this.shopId,
    required this.shopName,
    required this.sellType,
    required this.minimumQuantity,
    required this.inStock,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'thumbnail': thumbnail,
      'price': price,
      'old_price': oldPrice,
      'shop_id': shopId,
      'shop_name': shopName,
      'sell_type': sellType,
      'min_order_qty': minimumQuantity,
      'in_stock': inStock,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String?,
      thumbnail: map['thumbnail'] as String,
      price: (map['price'] is int)
          ? (map['price'] as int).toDouble()
          : map['price'] as double,
      oldPrice: (map['old_price'] is int)
          ? (map['old_price'] as int).toDouble()
          : map['old_price'] as double,
      discountPercentage: map['discount_percentage'].toString(),
      shopId: map['shop_id'] as int,
      shopName: map['shop_name'] as String,
      sellType: map['sell_type'] as String,
      minimumQuantity: map['min_order_qty'] as int,
      inStock: map['in_stock'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
