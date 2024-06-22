import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerymart/config/app_constants.dart';
import 'package:grocerymart/features/home/model/banner.dart';
import 'package:grocerymart/features/home/model/product.dart';
import 'package:grocerymart/utils/api_client.dart';

class HomeRepo {
  final Ref ref;
  HomeRepo(this.ref);

  Future<List<BannerModel>> getBanners() async {
    final response =
        await ref.read(apiClientProvider).get(AppConstant.getBanners);
    final List<dynamic> bannersData = response.data['data']['banners'];
    final List<BannerModel> bannerList =
        bannersData.map((banner) => BannerModel.fromMap(banner)).toList();
    return bannerList;
  }

  Future<List<Product>> getRecommendedProducts() async {
    final response = await ref.read(apiClientProvider).get(
          AppConstant.getRecommendedProducts,
        );
    final List<dynamic> productsData =
        response.data['data']['trandingProducts'];
    final List<Product> recommendedProducts =
        productsData.map((product) => Product.fromMap(product)).toList();

    print(">>>>>>>>>>>>>>>>> Data ${productsData.toString()}");
    return recommendedProducts;
  }
}

final homeRepo = Provider((ref) => HomeRepo(ref));
