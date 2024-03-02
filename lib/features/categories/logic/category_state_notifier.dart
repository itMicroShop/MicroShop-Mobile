import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerymart/features/categories/logic/category_repo.dart';
import 'package:grocerymart/features/categories/model/category_response.dart';

class CategoryStateNotifier extends StateNotifier<bool> {
  final Ref ref;
  CategoryStateNotifier(this.ref) : super(false);

  Future<CategoryResponseModel> getCategories({
    required int? shopId,
    required int? count,
    required int? categoryCount,
  }) async {
    state = true;
    try {
      final categoryResponse = await ref.read(categoryRepo).getCategories(
            shopId: shopId,
            count: count,
            categoryCount: categoryCount,
          );
      state = false;
      return categoryResponse;
    } catch (error) {
      debugPrint('we have got an errors: $error');
      state = false;
      return CategoryResponseModel(total: 0, categories: []);
    } finally {
      state = false;
    }
  }
}
