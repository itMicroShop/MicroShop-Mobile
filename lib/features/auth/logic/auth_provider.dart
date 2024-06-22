import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerymart/features/auth/logic/auth_state_notifier.dart';

final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, bool>((ref) {
  return AuthStateNotifier(ref);
});
