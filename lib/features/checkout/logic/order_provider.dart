import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerymart/features/checkout/logic/order_state_notifier.dart';

final orderStateNotifierProvider =
    StateNotifierProvider<OrderStateNotifier, bool>(
        (ref) => OrderStateNotifier(ref));
