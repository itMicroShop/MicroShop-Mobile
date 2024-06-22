import 'package:grocerymart/features/shop/model/user_review.dart';

class ReviewResponse {
  final int total;
  final List<UserReview> userReviews;
  ReviewResponse({
    required this.total,
    required this.userReviews,
  });
}
