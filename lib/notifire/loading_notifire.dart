import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingNotifire extends StateNotifier<bool> {
  LoadingNotifire() : super(false);

  void setLoading(bool isLoading) {
    state = isLoading;
  }
}

final loadingProvider = StateProvider((ref) => true);
