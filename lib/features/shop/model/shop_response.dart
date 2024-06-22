import 'package:grocerymart/features/shop/model/shop.dart';

class ShopResponseModel {
  final int total;
  final List<Shop> shopList;
  ShopResponseModel({
    required this.total,
    required this.shopList,
  });
}
