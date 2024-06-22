// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PlaceOrderModel {
  int shopId;
  int addressId;
  String paymentMethod;
  List<Product> product;
  String? note;
  int deliveryCharge;
  int? couponId;
  String paymentVia;
  PlaceOrderModel({
    required this.shopId,
    required this.addressId,
    required this.paymentMethod,
    required this.product,
    this.note,
    required this.deliveryCharge,
    this.couponId,
    required this.paymentVia,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shop_id': shopId,
      'address_id': addressId,
      'payment_method': paymentMethod,
      'product': product.map((x) => x.toMap()).toList(),
      'note': note,
      'delivery_charge': deliveryCharge,
      'coupon_id': couponId,
      'payment_via': paymentVia,
    };
  }

  factory PlaceOrderModel.fromMap(Map<String, dynamic> map) {
    return PlaceOrderModel(
      shopId: map['shopId'] as int,
      addressId: map['addressId'] as int,
      paymentMethod: map['paymentMethod'] as String,
      product: List<Product>.from(
        (map['product'] as List<int>).map<Product>(
          (x) => Product.fromMap(x as Map<String, dynamic>),
        ),
      ),
      note: map['note'] != null ? map['note'] as String : null,
      deliveryCharge: map['deliveryCharge'] as int,
      couponId: map['couponId'] != null ? map['couponId'] as int : null,
      paymentVia: map['payment_via'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceOrderModel.fromJson(String source) =>
      PlaceOrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Product {
  int productId;
  int productQTY;
  Product({
    required this.productId,
    required this.productQTY,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': productId,
      'qty': productQTY,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productId: map['id'] as int,
      productQTY: map['qty'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
