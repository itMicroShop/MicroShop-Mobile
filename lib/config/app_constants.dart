class AppConstant {
  // API URL
  static const String baseUrl = 'http://microshop.spatiulab.com/api';
  static const String signUp = '$baseUrl/sign-up';
  static const String loginUrl = '$baseUrl/sign-in';
  static const String sendOTP = '$baseUrl/forgot-password';
  static const String verifyOTP = '$baseUrl/forgot-password/otp/verify';
  static const String changePassword = '$baseUrl/reset-password';
  static const String getCategories = '$baseUrl/category/list';
  static const String getBanners = '$baseUrl/banners';
  static const String getRecommendedProducts = '$baseUrl/product/tranding';
  static const String getProducts = '$baseUrl/product/list';
  static const String getProductDetails = '$baseUrl/product/details';
  static const String placeOrder = '$baseUrl/order/store';
  static const String getOrders = '$baseUrl/orders';
  static const String getOrderDetails = '$baseUrl/order/details';
  static const String orderCancel = '$baseUrl/order/cancel';
  static const String updatePaymentStatus =
      '$baseUrl/order/update-payment-status';
  static const String getShopList = '$baseUrl/shop/list';
  static const String getUserReview = '$baseUrl/shop/reviews';
  static const String manageAddress = '$baseUrl/address/manage';
  static const String getUserAddresses = '$baseUrl/addresses';
  static const String applyCouponCode = '$baseUrl/coupons/apply';

  static const String getPrivacyPolicy = '$baseUrl/legal-pages/privacy_policy';
  static const String getTermsAndConditions =
      '$baseUrl/legal-pages/trams_of_service';
  static const String getAboutUsContent = '$baseUrl/legal-pages/about_us';
  static const String updateUserInfo = '$baseUrl/profile/update';
  static const String signOut = '$baseUrl/sign-out';

  // payment api url

  static const String paymentUrl = 'https://api.stripe.com/v1/payment_intents';

  // secret keys
  static const String publishableKey = 'pk_test_TYooMQauvdEDq54NiTphI7jx';
  static const String paymentSecret = 'sk_test_4eC39HqLyjWDarjtT1zdp7dc';
  static const String merchantCountryCode = 'USA';
  static const String currencyCode = 'USD';
}
