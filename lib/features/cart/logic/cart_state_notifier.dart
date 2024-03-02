import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerymart/features/cart/logic/cart_repo.dart';
import 'package:grocerymart/features/cart/model/coupon_apply.dart';

class CouponStateNotifier extends StateNotifier<bool> {
  final Ref ref;
  CouponStateNotifier(this.ref) : super(false);

  Future<CouponCode?> applyCouponCode({
    required int shopId,
    required String couponCode,
    required double amount,
  }) async {
    state = true;
    try {
      final response = await ref.read(cartRepo).applyCouponCode(
            shopId: shopId,
            couponCode: couponCode,
            amount: amount,
          );
      return response;
    } catch (error) {
      state = false;
      return null;
    } finally {
      state = false;
    }
  }
}
