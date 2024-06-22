import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerymart/features/home/logic/home_state_notifier.dart';

final homeStateNotifierProvider =
    StateNotifierProvider<HomeStateNotifier, bool>((ref) {
  return HomeStateNotifier(ref);
});
