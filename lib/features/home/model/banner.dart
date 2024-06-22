import 'dart:convert';

class BannerModel {
  final int id;
  final String media;
  BannerModel({
    required this.id,
    required this.media,
  });

  BannerModel copyWith({
    int? id,
    String? media,
  }) {
    return BannerModel(
      id: id ?? this.id,
      media: media ?? this.media,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'media': media,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['id'].toInt() as int,
      media: map['media'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BannerModel.fromJson(String source) => BannerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BannerModel(id: $id, media: $media)';

  @override
  bool operator ==(covariant BannerModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.media == media;
  }

  @override
  int get hashCode => id.hashCode ^ media.hashCode;
}