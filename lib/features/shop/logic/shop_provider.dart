import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerymart/features/shop/logic/shop_state_notifier.dart';

final shopNotifierProvider =
    StateNotifierProvider<ShopStateNotifier, bool>((ref) {
  return ShopStateNotifier(ref);
});
