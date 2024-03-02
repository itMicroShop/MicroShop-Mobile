import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerymart/config/app_constants.dart';
import 'package:grocerymart/features/home/model/product.dart';
import 'package:grocerymart/features/products/model/product_details.dart';
import 'package:grocerymart/features/products/model/product_response.dart';
import 'package:grocerymart/utils/api_client.dart';

class ProductRepo {
  final Ref ref;

  ProductRepo(this.ref);

  Future<ProductResponseModel> getProducts({
    required int? categoryId,
    required int? shopId,
    required String? search,
    required int? count,
    required int? productCount,
  }) async {
    Map<String, String> queryParams = {};
    if (categoryId != null) queryParams['category_id'] = categoryId.toString();
    if (shopId != null) queryParams['shop_id'] = shopId.toString();
    if (search != null) queryParams['search'] = search;
    if (count != null) queryParams['page'] = count.toString();
    if (productCount != null) queryParams['per_page'] = productCount.toString();

    final response = await ref
        .read(apiClientProvider)
        .get(AppConstant.getProducts, query: queryParams);

    final List<dynamic> productsData = response.data['data']['products'];
    final int totalProduct = response.data['data']['total'];
    final List<Product> products = productsData
        .map(
          (product) => Product.fromMap(product),
        )
        .toList();

    return ProductResponseModel(total: totalProduct, productList: products);
  }

  Future<ProductDetails> getProductDetails({required int productId}) async {
    final response = await ref
        .read(apiClientProvider)
        .get("${AppConstant.getProductDetails}/$productId");
    final productDetails = ProductDetails.fromMap(response.data['data']);
    return productDetails;
  }
}

final productRepo = Provider((ref) => ProductRepo(ref));
