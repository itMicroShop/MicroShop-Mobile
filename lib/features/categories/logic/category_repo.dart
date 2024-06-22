import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerymart/config/app_constants.dart';
import 'package:grocerymart/features/categories/model/category.dart';
import 'package:grocerymart/features/categories/model/category_response.dart';
import 'package:grocerymart/utils/api_client.dart';

class CategoryRepo {
  final Ref ref;
  CategoryRepo(this.ref);

  Future<CategoryResponseModel> getCategories({
    required int? shopId,
    required int? count,
    required int? categoryCount,
  }) async {
    Map<String, String> queryParams = {};
    if (shopId != null) queryParams['shop_id'] = shopId.toString();
    if (count != null) queryParams['page'] = count.toString();
    if (categoryCount != null) {
      queryParams['per_page'] = categoryCount.toString();
    }
    final response = await ref
        .read(apiClientProvider)
        .get(AppConstant.getCategories, query: queryParams);
    final List<dynamic> categoriesData = response.data['data']['categories'];
    // final int totalCategories = response.data['data']['total'];
    final List<Category> categoriesList =
        categoriesData.map((value) => Category.fromMap(value)).toList();
    return CategoryResponseModel(
      total: 10,
      categories: categoriesList,
    );
  }
}

final categoryRepo = Provider((ref) => CategoryRepo(ref));
