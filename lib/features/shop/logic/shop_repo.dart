import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerymart/config/app_constants.dart';
import 'package:grocerymart/features/shop/model/review_response.dart';
import 'package:grocerymart/features/shop/model/shop.dart';
import 'package:grocerymart/features/shop/model/shop_response.dart';
import 'package:grocerymart/features/shop/model/user_review.dart';
import 'package:grocerymart/utils/api_client.dart';

class ShopRepo {
  final Ref ref;
  ShopRepo(this.ref);

  Future<ShopResponseModel> getShopList({
    String? latitude,
    String? longitude,
    int? categoryId,
    int? count,
    int? shopCount,
    String? shop,
  }) async {
    Map<String, String> queryParams = {};
    if (latitude != null) queryParams['latitude'] = latitude;
    if (longitude != null) queryParams['longitude'] = longitude;
    if (categoryId != null) queryParams['category_id'] = categoryId.toString();
    if (shop != null) queryParams['search'] = shop;
    if (count != null) queryParams['page'] = count.toString();
    if (shopCount != null) queryParams['per_page'] = shopCount.toString();
    final response = await ref
        .read(apiClientProvider)
        .get(AppConstant.getShopList, query: queryParams);
    final List<dynamic> shopsData = response.data['data']['shops'];
    final int totalShop = response.data['data']['total'];
    final List<Shop> shopList =
        shopsData.map((shop) => Shop.fromMap(shop)).toList();

    return ShopResponseModel(total: totalShop, shopList: shopList);
  }

  Future<ReviewResponse> getUserReviews({
    required int shopId,
    required int? count,
    required int? reviewCount,
  }) async {
    Map<String, String> queryParams = {};
    queryParams['shop_id'] = shopId.toString();
    if (count != null) queryParams['page'] = count.toString();
    if (reviewCount != null) queryParams['per_page'] = reviewCount.toString();
    final response = await ref
        .read(apiClientProvider)
        .get(AppConstant.getUserReview, query: queryParams);
    final List<dynamic> reviewData = response.data['data']['reviews'];
    final int total = response.data['data']['total'];
    final List<UserReview> userReviews =
        reviewData.map((review) => UserReview.fromMap(review)).toList();
    return ReviewResponse(total: total, userReviews: userReviews);
  }
}

final shopRepo = Provider((ref) => ShopRepo(ref));
