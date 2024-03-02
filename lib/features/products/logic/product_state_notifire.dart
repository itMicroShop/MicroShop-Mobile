import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerymart/features/products/logic/product_repo.dart';
import 'package:grocerymart/features/products/model/product_details.dart';
import 'package:grocerymart/features/products/model/product_response.dart';

class ProductStateNotifier extends StateNotifier<bool> {
  final Ref ref;

  ProductStateNotifier(this.ref) : super(false);

  Future<ProductResponseModel> getProducts({
    required int? categoryId,
    required int? shopId,
    required String? search,
    required int? count,
    required int? productCount,
  }) async {
    state = true;
    try {
      final products = await ref.read(productRepo).getProducts(
          categoryId: categoryId,
          shopId: shopId,
          search: search,
          count: count,
          productCount: productCount);
      state = false;
      return products;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      state = false;
      return ProductResponseModel(total: 0, productList: []);
    } finally {
      state = false;
    }
  }

  Future<ProductDetails?> getProductDetails({required int productId}) async {
    // state = true;
    try {
      final productDetails =
          await ref.read(productRepo).getProductDetails(productId: productId);
      state = false;
      return productDetails;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      state = false;
      return null;
    } finally {
      state = false;
    }
  }
}
