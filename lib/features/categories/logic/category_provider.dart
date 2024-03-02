import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerymart/features/categories/logic/category_state_notifier.dart';

final categoryStateNotifierProvider =
    StateNotifierProvider<CategoryStateNotifier, bool>((ref) {
  return CategoryStateNotifier(ref);
});
