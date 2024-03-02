import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerymart/config/app_constants.dart';
import 'package:grocerymart/features/cart/model/coupon_apply.dart';
import 'package:grocerymart/features/cart/model/hive_cart_model.dart';
import 'package:grocerymart/utils/api_client.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartRepo {
  final Ref ref;
  CartRepo(this.ref);

  void incrementProductQuantity(
      {required int productId,
      required Box<HiveCartModel> box,
      required int index}) {
    final cartItem = getCartItemById(productId: productId, cartBox: box);
    if (cartItem != null) {
      cartItem.productsQTY++;
      box.putAt(index, cartItem);
    }
  }

  void decrementProductQuantity(
      {required int productId,
      required Box<HiveCartModel> cartBox,
      required int index}) {
    final cartItem = getCartItemById(productId: productId, cartBox: cartBox);
    if (cartItem != null) {
      if (cartItem.productsQTY > 1) {
        cartItem.productsQTY--;
        cartBox.putAt(index, cartItem);
      } else {
        cartBox.deleteAt(index);
      }
    }
  }

  HiveCartModel? getCartItemById(
      {required int productId, required Box<HiveCartModel> cartBox}) {
    final HiveCartModel cartItem = cartBox.values.firstWhere((product) {
      return product.id == productId;
    });

    return cartItem;
  }

  Future<CouponCode?> applyCouponCode({
    required int shopId,
    required String couponCode,
    required double amount,
  }) async {
    final response = await ref.read(apiClientProvider).post(
      AppConstant.applyCouponCode,
      data: {
        "shop_id": shopId,
        "coupon_code": couponCode,
        "amount": amount,
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data['data']['coupon'];
      final CouponCode couponCodeResponse = CouponCode.fromMap(data);
      return couponCodeResponse;
    }
    return null;
  }
}

final cartRepo = Provider((ref) => CartRepo(ref));
