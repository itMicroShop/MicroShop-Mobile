import 'package:grocerymart/features/categories/model/category.dart';

class CategoryResponseModel {
  final int total;
  final List<Category> categories;
  CategoryResponseModel({
    required this.total,
    required this.categories,
  });
}
