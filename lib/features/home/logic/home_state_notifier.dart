import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerymart/features/home/logic/home_repo.dart';
import 'package:grocerymart/features/home/model/banner.dart';
import 'package:grocerymart/features/home/model/product.dart';

class HomeStateNotifier extends StateNotifier<bool> {
  final Ref ref;
  HomeStateNotifier(this.ref) : super(false);

  Future<List<BannerModel>> getBanners() async {
    state = true;
    try {
      final bannerList = await ref.read(homeRepo).getBanners();
      state = false;
      return bannerList;
    } catch (error) {
      state = false;
      if (kDebugMode) {
        print(error);
      }
      return [];
    } finally {
      state = false;
    }
  }

  Future<List<Product>> getRecommendedProducts() async {
    state = true;
    try {
      final products = await ref.read(homeRepo).getRecommendedProducts();
      state = false;

      return products;
    } catch (error) {
      state = false;
      if (kDebugMode) {
        print(error);
      }
      return [];
    } finally {
      state = false;
    }
  }
}
