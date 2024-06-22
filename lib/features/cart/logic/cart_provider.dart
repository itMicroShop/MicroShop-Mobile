import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerymart/features/cart/logic/cart_state_notifier.dart';

final couponStateNotifierProvider =
    StateNotifierProvider<CouponStateNotifier, bool>(
        (ref) => CouponStateNotifier(ref));
