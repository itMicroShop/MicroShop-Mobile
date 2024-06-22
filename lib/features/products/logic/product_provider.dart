import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerymart/features/products/logic/product_state_notifire.dart';

final productNotifierProvider =
    StateNotifierProvider<ProductStateNotifier, bool>((ref) {
  return ProductStateNotifier(ref);
});
