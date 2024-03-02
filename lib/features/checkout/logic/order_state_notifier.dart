import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerymart/features/checkout/logic/order_repo.dart';
import 'package:grocerymart/features/checkout/model/place_order.dart';

class OrderStateNotifier extends StateNotifier<bool> {
  final Ref ref;
  OrderStateNotifier(this.ref) : super(false);

  Future<int?> placeOrder({required PlaceOrderModel orderData}) async {
    try {
      state = true;
      final int orderId =
          await ref.read(orderRepo).placeOrder(orderData: orderData);
      state = false;
      return orderId;
    } catch (e) {
      state = false;
      if (kDebugMode) {
        print(e);
      }
      return null;
    } finally {
      state = false;
    }
  }

  Future<String?> cancelOrder({required int orderId}) async {
    try {
      state = true;
      final String message =
          await ref.read(orderRepo).cancelOrder(orderId: orderId);
      state = false;
      return message;
    } catch (e) {
      state = false;
      if (kDebugMode) {
        print(e);
      }
      return null;
    } finally {
      state = false;
    }
  }
}
