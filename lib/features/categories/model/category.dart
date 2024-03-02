import 'dart:convert';

class Category {
  final int id;
  final int? shopId;
  final String? name;
  final String icon;
  final String description;
  final String slug;
  Category({
    required this.id,
    this.shopId,
    this.name,
    required this.icon,
    required this.description,
    required this.slug,
  });

  Category copyWith({
    int? id,
    int? shopId,
    String? name,
    String? icone,
    String? description,
    String? slug,
  }) {
    return Category(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      name: name ?? this.name,
      icon: icone ?? icon,
      description: description ?? this.description,
      slug: slug ?? this.slug,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'shop_id': shopId,
      'name': name,
      'icon': icon,
      'description': description,
      'slug': slug,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'].toInt() as int,
      shopId: map['shop_id']?.toInt() as int?,
      name: map['name'] as String?,
      icon: map['icon'] as String,
      description: map['description'] ?? "",
      slug: map['slug'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Category(id: $id, shop_id: $shopId, name: $name, icon: $icon, description: $description, slug: $slug)';
  }

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.shopId == shopId &&
        other.name == name &&
        other.icon == icon &&
        other.description == description &&
        other.slug == slug;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        shopId.hashCode ^
        name.hashCode ^
        icon.hashCode ^
        description.hashCode ^
        slug.hashCode;
  }
}
