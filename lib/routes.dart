import 'package:flutter/material.dart';
import 'package:grocerymart/features/auth/view/change_pass.dart';
import 'package:grocerymart/features/auth/view/login_screen.dart';
import 'package:grocerymart/features/auth/view/pass_recover.dart';
import 'package:grocerymart/features/auth/view/sign_up.dart';
import 'package:grocerymart/features/auth/view/verify_otp.dart';
import 'package:grocerymart/features/cart/view/cart_view.dart';
import 'package:grocerymart/features/categories/views/category_view.dart';
import 'package:grocerymart/features/categories/views/category_wise_shop.dart';
import 'package:grocerymart/features/checkout/view/order_details.dart';
import 'package:grocerymart/features/checkout/view/order_screen.dart';
import 'package:grocerymart/features/dashboard/views/dashboard.dart';
import 'package:grocerymart/features/dashboard/views/on_boarding_screen.dart';
import 'package:grocerymart/features/dashboard/views/splash_screen.dart';
import 'package:grocerymart/features/home/model/product.dart';
import 'package:grocerymart/features/home/view/widget/category_tile.dart';
import 'package:grocerymart/features/menu/model/user_address.dart';
import 'package:grocerymart/features/menu/view/manage_address.dart';
import 'package:grocerymart/features/menu/view/profile.dart';
import 'package:grocerymart/features/menu/view/user_address.dart';
import 'package:grocerymart/features/other/view/about_us.dart';
import 'package:grocerymart/features/other/view/privacy_policy.dart';
import 'package:grocerymart/features/other/view/terms_and_conditions.dart';
import 'package:grocerymart/features/products/view/own_products.dart';
import 'package:grocerymart/features/products/view/product_details.dart';
import 'package:grocerymart/features/shop/model/shop.dart';
import 'package:grocerymart/features/shop/view/shop_page.dart';
import 'package:grocerymart/service/hive_model.dart';
import 'package:grocerymart/util/entensions.dart';
import 'package:page_transition/page_transition.dart';

import 'features/checkout/view/checkout_screen.dart';

class Routes {
  /*We are mapping all th eroutes here
  so that we can call any named route
  without making typing mistake
  */
  Routes._();
  //core
  static const splash = '/';
  static const onBoarding = '/onBoarding';
  static const login = '/login';
  static const signUp = '/signUp';
  static const passwordRecover = '/passwordRecover';
  static const verifyOTPScreen = '/verifyOTPScreen';
  static const changePasswordScreen = '/changePasswordScreen';
  static const dashboard = '/dashboard';
  static const ownProductScreen = '/ownProductScreen';
  static const categoryScreen = '/categoryScreen';
  static const categoryWiseShop = '/categoryWiseShop';
  static const productDetailsScreen = '/productDetailsScreen';
  static const storeDetailsScreen = '/storeDetailsScreen';
  static const cartScreen = '/cartScreen';
  static const checkoutScreen = '/checkoutScreen';
  static const addUserAddressScreen = '/addUserAddressScreen';
  static const manageAddressScreen = '/manageAddressScreen';
  static const myOrdersScreen = '/myOrdersScreen';
  static const orderDetails = '/orderDetails';
  static const privacyPolicyScreen = '/privacyPolicyScreen';
  static const termsAndConditionsScreen = '/termsAndConditionsScreen';
  static const aboutUsScreen = '/aboutUsScreen';
  static const profileScreen = '/profileScreen';
}

Route generatedRoutes(RouteSettings settings) {
  Widget child;

  switch (settings.name) {
    //core
    case Routes.splash:
      child = const SplashScreen();
      break;
    case Routes.onBoarding:
      child = const OnBoardingScreen();
      break;
    case Routes.login:
      child = const LoginScreen();
      break;
    case Routes.signUp:
      child = const SignUpScreen();
      break;
    case Routes.passwordRecover:
      child = PassRecoverScreen();
      break;
    case Routes.verifyOTPScreen:
      VerifyOTPArgument argument = settings.arguments as VerifyOTPArgument;
      child = VerifyOTPScreen(
        argument: argument,
      );
      break;
    case Routes.changePasswordScreen:
      String token = settings.arguments as String;
      child = ChangePasswordScreen(
        token: token,
      );
      break;
    case Routes.dashboard:
      child = const DashboardScreen();
      break;
    case Routes.ownProductScreen:
      child = OwnProductView(
        products: settings.arguments as List<Product>,
      );
      break;
    case Routes.addUserAddressScreen:
      child = AddUserAddressScreen(
        userAddress: settings.arguments as UserAddress?,
      );
      break;
    case Routes.manageAddressScreen:
      child = const ManageAddressScreen();
      break;
    case Routes.categoryScreen:
      CategoryArgument args = settings.arguments as CategoryArgument;
      child = CategoryScreen(
        catgoryList: args.categoryList,
        selcetedIndex: args.index,
        categoryId: args.categoryId,
        shopId: args.shopId,
      );
      break;
    case Routes.categoryWiseShop:
      child = CategoryWiseShop(
        categoryId: settings.arguments as int,
      );
      break;
    case Routes.productDetailsScreen:
      child = ProductDetailsScreen(
        productId: settings.arguments as int,
      );
      break;
    case Routes.storeDetailsScreen:
      child = StoreDetailsScreen(
        shopDetails: settings.arguments as Shop,
      );
      break;
    case Routes.cartScreen:
      child = const CartScreen();
      break;
    case Routes.checkoutScreen:
      CheckoutArgument checkoutArgument =
          settings.arguments as CheckoutArgument;
      child = CheckoutScreen(
        checkoutArgument: checkoutArgument,
      );
      break;
    case Routes.myOrdersScreen:
      child = const OrderScreen();
      break;
    case Routes.orderDetails:
      child = OrderDetailsScreen(
        orderId: settings.arguments as int,
      );
      break;
    case Routes.profileScreen:
      child = ProfileScreen(
        userInfo: settings.arguments as User,
      );
      break;
    case Routes.privacyPolicyScreen:
      child = const PrivacyPolicyScreen();
      break;
    case Routes.termsAndConditionsScreen:
      child = const TermsAndConditions();
      break;
    case Routes.aboutUsScreen:
      child = const AboutUs();
      break;

    default:
      throw Exception('Invalid route: ${settings.name}');
  }
  debugPrint('Route: ${settings.name}');

  return PageTransition(
    child: child,
    type: PageTransitionType.fade,
    settings: settings,
    duration: 300.miliSec,
    reverseDuration: 300.miliSec,
  );
}
