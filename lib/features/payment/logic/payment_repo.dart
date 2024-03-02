import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:grocerymart/config/app_constants.dart';
import 'package:grocerymart/features/cart/model/hive_cart_model.dart';
import 'package:grocerymart/routes.dart';
import 'package:grocerymart/util/global_function.dart';
import 'package:grocerymart/utils/api_client.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class PaymentRepo extends ChangeNotifier {
  final Ref ref;
  PaymentRepo(this.ref);
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<void> stripePayment({
    required int amount,
    required int orderId,
    required Box<HiveCartModel> cartBox,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      int parseAmount = amount * 100;

      final response =
          await http.post(Uri.parse(AppConstant.paymentUrl), headers: {
        'Authorization': 'Bearer ${AppConstant.paymentSecret}',
        'Content-Type': 'application/x-www-form-urlencoded'
      }, body: {
        "amount": parseAmount.toString(),
        "currency": AppConstant.currencyCode,
      });
      final responseData = jsonDecode(response.body);
      final String clientSecret = responseData['client_secret'];
      const googlePay = PaymentSheetGooglePay(
        merchantCountryCode: AppConstant.merchantCountryCode,
        currencyCode: AppConstant.currencyCode,
        testEnv: true,
      );

      await initializePaymentSheet(
        paymentIntentClientSecret: clientSecret,
        googlePay: googlePay,
      );
      displayPaymentSheet(orderId: orderId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      if (e is PlatformException) {
        final errorMessage = e.message ?? 'An error occurred during payment';
        EasyLoading.showError('Payment failed: $errorMessage');
      } else {
        EasyLoading.showError('Payment failed');
      }
    }
  }

  Future<void> initializePaymentSheet({
    required String paymentIntentClientSecret,
    required PaymentSheetGooglePay googlePay,
  }) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: paymentIntentClientSecret,
      style: ThemeMode.light,
      merchantDisplayName: 'grocerymart',
      googlePay: googlePay,
    ));
  }

  Future<void> displayPaymentSheet({required int orderId}) async {
    try {
      await Stripe.instance.presentPaymentSheet(
        options: const PaymentSheetPresentOptions(timeout: 1200000),
      );
      EasyLoading.showSuccess('Payment successfully completed');
      updatePaymentStatus(orderId: orderId, paymentStatus: 'accepted');
      ApGlobalFunctions.navigatorKey.currentState
          ?.pushNamedAndRemoveUntil(Routes.dashboard, (route) => false);
    } catch (e) {
      ApGlobalFunctions.navigatorKey.currentState
          ?.pushNamedAndRemoveUntil(Routes.dashboard, (route) => false);
      if (e is PlatformException) {
        final errorMessage = e.message ?? 'An error occurred during payment';
        EasyLoading.showError('Payment failed: $errorMessage');
      } else {
        EasyLoading.showError('Payment failed');
      }
    }
  }

  Future<bool> updatePaymentStatus(
      {required int orderId, required String paymentStatus}) async {
    final response = await ref
        .read(apiClientProvider)
        .post(AppConstant.updatePaymentStatus, data: {
      'order_id': orderId,
      'payment_status': paymentStatus,
    });
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}

final paymentRepo = ChangeNotifierProvider((ref) => PaymentRepo(ref));
