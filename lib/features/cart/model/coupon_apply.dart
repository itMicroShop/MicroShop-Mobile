class CouponCode {
  final int id;
  final String code;
  final double discount;
  final double amount;
  final double discountAmount;
  final double minAmount;
  final String type;
  CouponCode({
    required this.id,
    required this.code,
    required this.discount,
    required this.amount,
    required this.discountAmount,
    required this.minAmount,
    required this.type,
  });

  CouponCode copyWith({
    int? id,
    String? code,
    double? discount,
    double? amount,
    double? discountAmount,
    double? minAmount,
    String? type,
  }) {
    return CouponCode(
      id: id ?? this.id,
      code: code ?? this.code,
      discount: discount ?? this.discount,
      amount: amount ?? this.amount,
      discountAmount: discountAmount ?? this.discountAmount,
      minAmount: minAmount ?? this.minAmount,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'discount': discount,
      'amount': amount,
      'discount_amount': discountAmount,
      'min_amount': minAmount,
      'type': type,
    };
  }

  factory CouponCode.fromMap(Map<String, dynamic> map) {
    return CouponCode(
      id: map['id'].toInt() as int,
      code: map['code'] as String,
      discount: (map['discount'] is int)
          ? (map['discount'] as int).toDouble()
          : map['discount'] as double,
      amount: (map['amount'] is int)
          ? (map['amount'] as int).toDouble()
          : map['amount'] as double,
      discountAmount: (map['discount_amount'] is int)
          ? (map['discount_amount'] as int).toDouble()
          : map['discount_amount'] as double,
      minAmount: (map['min_amount'] is int)
          ? (map['min_amount'] as int).toDouble()
          : map['min_amount'] as double,
      type: map['type'] as String,
    );
  }
}
