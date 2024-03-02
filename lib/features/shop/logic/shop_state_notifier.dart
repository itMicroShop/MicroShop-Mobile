import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerymart/features/shop/logic/shop_repo.dart';
import 'package:grocerymart/features/shop/model/review_response.dart';
import 'package:grocerymart/features/shop/model/shop_response.dart';

class ShopStateNotifier extends StateNotifier<bool> {
  final Ref ref;
  ShopStateNotifier(this.ref) : super(false);

  Future<ShopResponseModel> getShopList(
      {String? latitude,
      String? longitude,
      int? categoryId,
      String? shop,
      int? count,
      int? shopCount}) async {
    state = true;
    try {
      ShopResponseModel shopList = await ref.read(shopRepo).getShopList(
            latitude: latitude,
            longitude: longitude,
            categoryId: categoryId,
            shop: shop,
            count: count,
            shopCount: shopCount,
          );
      state = false;
      return shopList;
    } catch (e) {
      state = false;
      if (kDebugMode) {
        print(e);
      }
      return ShopResponseModel(total: 0, shopList: []);
    } finally {
      state = false;
    }
  }

  Future<ReviewResponse> getUserReviews({
    required int shopId,
    required int? count,
    required int? reviewCount,
  }) async {
    state = true;
    try {
      ReviewResponse response = await ref.read(shopRepo).getUserReviews(
            shopId: shopId,
            count: count,
            reviewCount: reviewCount,
          );
      state = false;
      return response;
    } catch (e) {
      state = false;
      if (kDebugMode) {
        print(e);
      }
      return ReviewResponse(total: 0, userReviews: []);
    } finally {
      state = false;
    }
  }
}
