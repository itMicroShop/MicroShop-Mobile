import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:grocerymart/features/home/model/banner.dart';

class Shop {
  final int id;
  final String name;
  final String description;
  final String logo;
  final String thumbnail;
  final List<BannerModel> banners;
  final String rating;
  final String distance;
  final String deliveryTime;
  final String openTime;
  final String closeTime;
  final int totalCategories;
  final int totalProducts;
  final int totalReviews;
  Shop({
    required this.id,
    required this.name,
    required this.description,
    required this.logo,
    required this.thumbnail,
    required this.banners,
    required this.rating,
    required this.distance,
    required this.deliveryTime,
    required this.openTime,
    required this.closeTime,
    required this.totalCategories,
    required this.totalProducts,
    required this.totalReviews,
  });

  Shop copyWith({
    int? id,
    String? name,
    String? description,
    String? logo,
    String? thumbnail,
    List<BannerModel>? banners,
    String? rating,
    String? distance,
    String? deliveryTime,
    String? openTime,
    String? closeTime,
    int? totalCategories,
    int? totalProducts,
    int? totalReviews,
  }) {
    return Shop(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      logo: logo ?? this.logo,
      thumbnail: thumbnail ?? this.thumbnail,
      banners: banners ?? this.banners,
      rating: rating ?? this.rating,
      distance: distance ?? this.distance,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
      totalCategories: totalCategories ?? this.totalCategories,
      totalProducts: totalProducts ?? this.totalProducts,
      totalReviews: totalReviews ?? this.totalReviews,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'logo': logo,
      'thumbnail': thumbnail,
      'banners': banners.map((x) => x.toMap()).toList(),
      'rating': rating,
      'distance': distance,
      'delivery_time': deliveryTime,
      'open_time': openTime,
      'close_time': closeTime,
      'total_categories': totalCategories,
      'total_products': totalProducts,
      'total_reviews': totalReviews,
    };
  }

  factory Shop.fromMap(Map<String, dynamic> map) {
    return Shop(
      id: map['id'].toInt() as int,
      name: map['name'] as String,
      description: map['description'] ?? '',
      logo: map['logo'] ?? '',
      thumbnail: map['thumbnail'] ?? '',
      banners: List<BannerModel>.from(
        (map['banners'] as List<dynamic>).map<BannerModel>(
          (x) => BannerModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      rating: map['rating'] as String,
      distance: map['distance'] as String,
      deliveryTime: map['delivery_time'] as String,
      openTime: map['open_time'] as String,
      closeTime: map['close_time'] as String,
      totalCategories: map['total_categories'].toInt() as int,
      totalProducts: map['total_products'].toInt() as int,
      totalReviews: map['total_reviews'].toInt() as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Shop.fromJson(String source) =>
      Shop.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Shop(id: $id, name: $name, description: $description, logo: $logo, thumbnail: $thumbnail, banners: $banners, rating: $rating, distance: $distance, delivery_time: $deliveryTime, open_time: $openTime, close_time: $closeTime, total_categories: $totalCategories, total_products: $totalProducts, total_reviews: $totalReviews)';
  }

  @override
  bool operator ==(covariant Shop other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.logo == logo &&
        other.thumbnail == thumbnail &&
        listEquals(other.banners, banners) &&
        other.rating == rating &&
        other.distance == distance &&
        other.deliveryTime == deliveryTime &&
        other.openTime == openTime &&
        other.closeTime == closeTime &&
        other.totalCategories == totalCategories &&
        other.totalProducts == totalProducts &&
        other.totalReviews == totalReviews;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        logo.hashCode ^
        thumbnail.hashCode ^
        banners.hashCode ^
        rating.hashCode ^
        distance.hashCode ^
        deliveryTime.hashCode ^
        openTime.hashCode ^
        closeTime.hashCode ^
        totalCategories.hashCode ^
        totalProducts.hashCode ^
        totalReviews.hashCode;
  }
}
