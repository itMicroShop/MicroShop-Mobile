import 'package:grocerymart/features/home/model/product.dart';

class ProductResponseModel {
  final int total;
  final List<Product> productList;
  ProductResponseModel({
    required this.total,
    required this.productList,
  });
}
