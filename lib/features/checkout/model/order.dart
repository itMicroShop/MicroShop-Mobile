class Order {
  final int id;
  final String status;
  final String paymentStatus;
  final double subTotal;
  final double total;
  final String deliveryCharge;
  final String identityCode;
  final double discount;
  final String shopName;
  final String shopLogo;
  Order({
    required this.id,
    required this.status,
    required this.paymentStatus,
    required this.subTotal,
    required this.total,
    required this.deliveryCharge,
    required this.identityCode,
    required this.discount,
    required this.shopName,
    required this.shopLogo,
  });

  Order copyWith({
    int? id,
    String? status,
    String? paymentStatus,
    double? subTotal,
    double? total,
    String? deliveryCharge,
    String? identityCode,
    double? discount,
    String? shopName,
    String? shopLogo,
  }) {
    return Order(
      id: id ?? this.id,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      subTotal: subTotal ?? this.subTotal,
      total: total ?? this.total,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      identityCode: identityCode ?? this.identityCode,
      discount: discount ?? this.discount,
      shopName: shopName ?? this.shopName,
      shopLogo: shopLogo ?? this.shopLogo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'payment_status': paymentStatus,
      'sub_total': subTotal,
      'total': total,
      'delivery_charge': deliveryCharge,
      'identity_code': identityCode,
      'discount': discount,
      'shop_name': shopName,
      'shop_logo': shopLogo,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'].toInt() as int,
      status: map['status'] as String,
      paymentStatus: map['payment_status'] as String,
      subTotal: map['sub_total'].toDouble() as double,
      total: map['total'].toDouble() as double,
      deliveryCharge: map['delivery_charge'] as String,
      identityCode: map['identity_code'] as String,
      discount: (map['discount'] is int)
          ? (map['discount'] as int).toDouble()
          : map['discount'] as double,
      shopName: map['shop_name'] as String,
      shopLogo: map['shop_logo'] as String,
    );
  }
}
