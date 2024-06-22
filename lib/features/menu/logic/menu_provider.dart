import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerymart/features/menu/logic/menu_state_notifier.dart';

final menuStateNotifierProvider =
    StateNotifierProvider<MenuStateNotifier, bool>((ref) {
  return MenuStateNotifier(ref);
});
