import 'dart:convert';

class UserReview {
  final int id;
  final String userName;
  final String userProfilePhoto;
  final String date;
  final String rating;
  final String message;
  UserReview({
    required this.id,
    required this.userName,
    required this.userProfilePhoto,
    required this.date,
    required this.rating,
    required this.message,
  });

  UserReview copyWith({
    int? id,
    String? userName,
    String? userProfilePhoto,
    String? date,
    String? rating,
    String? message,
  }) {
    return UserReview(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      userProfilePhoto: userProfilePhoto ?? this.userProfilePhoto,
      date: date ?? this.date,
      rating: rating ?? this.rating,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_name': userName,
      'user_profile_photo': userProfilePhoto,
      'date': date,
      'rating': rating,
      'message': message,
    };
  }

  factory UserReview.fromMap(Map<String, dynamic> map) {
    return UserReview(
      id: map['id'].toInt() as int,
      userName: map['user_name'] as String,
      userProfilePhoto: map['user_profile_photo'] as String,
      date: map['date'] as String,
      rating: map['rating'] as String,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserReview.fromJson(String source) =>
      UserReview.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserReview(id: $id, user_name: $userName, user_profile_photo: $userProfilePhoto, date: $date, rating: $rating, message: $message)';
  }

  @override
  bool operator ==(covariant UserReview other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userName == userName &&
        other.userProfilePhoto == userProfilePhoto &&
        other.date == date &&
        other.rating == rating &&
        other.message == message;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userName.hashCode ^
        userProfilePhoto.hashCode ^
        date.hashCode ^
        rating.hashCode ^
        message.hashCode;
  }
}
