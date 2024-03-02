import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:grocerymart/features/home/model/banner.dart';
import 'package:grocerymart/features/home/model/product.dart';

class ProductDetails {
  final ProductWithShop product;
  final List<Product> products;
  ProductDetails({
    required this.product,
    required this.products,
  });

  ProductDetails copyWith({
    ProductWithShop? product,
    List<Product>? products,
  }) {
    return ProductDetails(
      product: product ?? this.product,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product.toMap(),
      'related_products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductDetails.fromMap(Map<String, dynamic> map) {
    return ProductDetails(
      product: ProductWithShop.fromMap(map['product'] as Map<String, dynamic>),
      products: List<Product>.from(
        (map['related_products'] as List<dynamic>).map<Product>(
          (x) => Product.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductDetails.fromJson(String source) =>
      ProductDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ProductDetails(product: $product, related_products: $products)';

  @override
  bool operator ==(covariant ProductDetails other) {
    if (identical(this, other)) return true;

    return other.product == product && listEquals(other.products, products);
  }

  @override
  int get hashCode => product.hashCode ^ products.hashCode;
}

class ProductWithShop {
  final int id;
  final String name;
  final String description;
  final String thumbnail;
  final double price;
  final double oldPrice;
  final String discountPercentage;
  final Shop shop;
  final String sellType;
  final int minOrderQty;
  final bool inStock;
  ProductWithShop({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
    required this.price,
    required this.oldPrice,
    required this.discountPercentage,
    required this.shop,
    required this.sellType,
    required this.minOrderQty,
    required this.inStock,
  });

  ProductWithShop copyWith({
    int? id,
    String? name,
    String? description,
    String? thumbnail,
    double? price,
    double? oldPrice,
    String? discountPercentage,
    Shop? shop,
    String? sellType,
    int? minOrderQty,
    bool? inStock,
  }) {
    return ProductWithShop(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      thumbnail: thumbnail ?? this.thumbnail,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      shop: shop ?? this.shop,
      sellType: sellType ?? this.sellType,
      minOrderQty: minOrderQty ?? this.minOrderQty,
      inStock: inStock ?? this.inStock,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'thumbnail': thumbnail,
      'price': price,
      'old_price': oldPrice,
      'discount_percentage': discountPercentage,
      'shop': shop.toMap(),
      'sell_type': sellType,
      'min_order_qty': minOrderQty,
      'in_stock': inStock,
    };
  }

  factory ProductWithShop.fromMap(Map<String, dynamic> map) {
    return ProductWithShop(
      id: map['id'].toInt() as int,
      name: map['name'] as String,
      description: map['description'] ?? '',
      thumbnail: map['thumbnail'] as String,
      price: map['price'].toDouble() as double,
      oldPrice: map['old_price'].toDouble() as double,
      discountPercentage: map['discount_percentage'] as String,
      shop: Shop.fromMap(map['shop'] as Map<String, dynamic>),
      sellType: map['sell_type'] as String,
      minOrderQty: map['min_order_qty'].toInt() as int,
      inStock: map['in_stock'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductWithShop.fromJson(String source) =>
      ProductWithShop.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, thumbnail: $thumbnail, price: $price, old_price: $oldPrice, discount_percentage: $discountPercentage, shop: $shop, sell_type: $sellType, min_order_qty: $minOrderQty, in_stock: $inStock)';
  }

  @override
  bool operator ==(covariant ProductWithShop other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.thumbnail == thumbnail &&
        other.price == price &&
        other.oldPrice == oldPrice &&
        other.discountPercentage == discountPercentage &&
        other.shop == shop &&
        other.sellType == sellType &&
        other.minOrderQty == minOrderQty &&
        other.inStock == inStock;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        thumbnail.hashCode ^
        price.hashCode ^
        oldPrice.hashCode ^
        discountPercentage.hashCode ^
        shop.hashCode ^
        sellType.hashCode ^
        minOrderQty.hashCode ^
        inStock.hashCode;
  }
}

class Shop {
  final int id;
  final String name;
  final String description;
  final String logo;
  final List<BannerModel> banner;
  final String rating;
  final String distance;
  final String deliveryTime;
  Shop({
    required this.id,
    required this.name,
    required this.description,
    required this.logo,
    required this.banner,
    required this.rating,
    required this.distance,
    required this.deliveryTime,
  });

  Shop copyWith({
    int? id,
    String? name,
    String? description,
    String? logo,
    List<BannerModel>? banner,
    String? rating,
    String? distance,
    String? deliveryTime,
  }) {
    return Shop(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      logo: logo ?? this.logo,
      banner: banner ?? this.banner,
      rating: rating ?? this.rating,
      distance: distance ?? this.distance,
      deliveryTime: deliveryTime ?? this.deliveryTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'logo': logo,
      'banner': banner.map((x) => x.toMap()).toList(),
      'rating': rating,
      'distance': distance,
      'delivery_time': deliveryTime,
    };
  }

  factory Shop.fromMap(Map<String, dynamic> map) {
    return Shop(
      id: map['id'].toInt() as int,
      name: map['name'] as String,
      description: map['description'] ?? '',
      logo: map['logo'] as String,
      banner: List<BannerModel>.from(
        (map['banners'] as List<dynamic>).map<BannerModel>(
          (e) => BannerModel.fromMap(e as Map<String, dynamic>),
        ),
      ),
      rating: map['rating'] as String,
      distance: map['distance'] as String,
      deliveryTime: map['delivery_time'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Shop.fromJson(String source) =>
      Shop.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Shop(id: $id, name: $name, description: $description, logo: $logo, banner: $banner, rating: $rating, distance: $distance, delivery_time: $deliveryTime)';
  }

  @override
  bool operator ==(covariant Shop other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.logo == logo &&
        other.banner == banner &&
        other.rating == rating &&
        other.distance == distance &&
        other.deliveryTime == deliveryTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        logo.hashCode ^
        banner.hashCode ^
        rating.hashCode ^
        distance.hashCode ^
        deliveryTime.hashCode;
  }
}
