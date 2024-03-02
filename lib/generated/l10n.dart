// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Please login to continue shopping`
  String get loginDes {
    return Intl.message(
      'Please login to continue shopping',
      name: 'loginDes',
      desc: '',
      args: [],
    );
  }

  /// `Email or Phone`
  String get emialOrPhone {
    return Intl.message(
      'Email or Phone',
      name: 'emialOrPhone',
      desc: '',
      args: [],
    );
  }

  /// `Your Password`
  String get yourPassword {
    return Intl.message(
      'Your Password',
      name: 'yourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password`
  String get forgetPassword {
    return Intl.message(
      'Forgot your password',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `field cannot be empty`
  String get validationMessage {
    return Intl.message(
      'field cannot be empty',
      name: 'validationMessage',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get allReadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'allReadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Deliver to`
  String get deliverTo {
    return Intl.message(
      'Deliver to',
      name: 'deliverTo',
      desc: '',
      args: [],
    );
  }

  /// ` Recommended for you`
  String get recommendedProduct {
    return Intl.message(
      ' Recommended for you',
      name: 'recommendedProduct',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Nearby store`
  String get nearByStore {
    return Intl.message(
      'Nearby store',
      name: 'nearByStore',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get viewAll {
    return Intl.message(
      'View All',
      name: 'viewAll',
      desc: '',
      args: [],
    );
  }

  /// `No Product Found!`
  String get noProductFound {
    return Intl.message(
      'No Product Found!',
      name: 'noProductFound',
      desc: '',
      args: [],
    );
  }

  /// `Search for products`
  String get searchProducts {
    return Intl.message(
      'Search for products',
      name: 'searchProducts',
      desc: '',
      args: [],
    );
  }

  /// `Product Details`
  String get productDetails {
    return Intl.message(
      'Product Details',
      name: 'productDetails',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong!`
  String get someThingWrong {
    return Intl.message(
      'Something went wrong!',
      name: 'someThingWrong',
      desc: '',
      args: [],
    );
  }

  /// `Product details not found!`
  String get productDNF {
    return Intl.message(
      'Product details not found!',
      name: 'productDNF',
      desc: '',
      args: [],
    );
  }

  /// `Distance from my location`
  String get distanceFML {
    return Intl.message(
      'Distance from my location',
      name: 'distanceFML',
      desc: '',
      args: [],
    );
  }

  /// `Estimated delivery time`
  String get edtimatedDT {
    return Intl.message(
      'Estimated delivery time',
      name: 'edtimatedDT',
      desc: '',
      args: [],
    );
  }

  /// `Related items`
  String get relatedItems {
    return Intl.message(
      'Related items',
      name: 'relatedItems',
      desc: '',
      args: [],
    );
  }

  /// `All Categories`
  String get allCategories {
    return Intl.message(
      'All Categories',
      name: 'allCategories',
      desc: '',
      args: [],
    );
  }

  /// `No category found!`
  String get noCategoriesFound {
    return Intl.message(
      'No category found!',
      name: 'noCategoriesFound',
      desc: '',
      args: [],
    );
  }

  /// `Shop`
  String get shop {
    return Intl.message(
      'Shop',
      name: 'shop',
      desc: '',
      args: [],
    );
  }

  /// `Shop not found!`
  String get shopNotfound {
    return Intl.message(
      'Shop not found!',
      name: 'shopNotfound',
      desc: '',
      args: [],
    );
  }

  /// `Search for shop`
  String get searchShop {
    return Intl.message(
      'Search for shop',
      name: 'searchShop',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `My Order`
  String get myorder {
    return Intl.message(
      'My Order',
      name: 'myorder',
      desc: '',
      args: [],
    );
  }

  /// `Manage Address`
  String get manageAddress {
    return Intl.message(
      'Manage Address',
      name: 'manageAddress',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get termsConditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'termsConditions',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get aboutUs {
    return Intl.message(
      'About Us',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Update Profile`
  String get updateProfile {
    return Intl.message(
      'Update Profile',
      name: 'updateProfile',
      desc: '',
      args: [],
    );
  }

  /// `Profile is updated successful`
  String get profileUS {
    return Intl.message(
      'Profile is updated successful',
      name: 'profileUS',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Add New Address`
  String get addNewAddress {
    return Intl.message(
      'Add New Address',
      name: 'addNewAddress',
      desc: '',
      args: [],
    );
  }

  /// `Area`
  String get area {
    return Intl.message(
      'Area',
      name: 'area',
      desc: '',
      args: [],
    );
  }

  /// `Flat`
  String get flat {
    return Intl.message(
      'Flat',
      name: 'flat',
      desc: '',
      args: [],
    );
  }

  /// `Postal Code`
  String get postalCode {
    return Intl.message(
      'Postal Code',
      name: 'postalCode',
      desc: '',
      args: [],
    );
  }

  /// `Address Line 1`
  String get addressLine1 {
    return Intl.message(
      'Address Line 1',
      name: 'addressLine1',
      desc: '',
      args: [],
    );
  }

  /// `Address Line 2`
  String get addressLine2 {
    return Intl.message(
      'Address Line 2',
      name: 'addressLine2',
      desc: '',
      args: [],
    );
  }

  /// `Address Tag`
  String get addressTag {
    return Intl.message(
      'Address Tag',
      name: 'addressTag',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Office`
  String get office {
    return Intl.message(
      'Office',
      name: 'office',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Make it default address`
  String get makeDefault {
    return Intl.message(
      'Make it default address',
      name: 'makeDefault',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Opps user address not found!`
  String get userAddressNotFound {
    return Intl.message(
      'Opps user address not found!',
      name: 'userAddressNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get enterName {
    return Intl.message(
      'Enter your name',
      name: 'enterName',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number`
  String get enterPhone {
    return Intl.message(
      'Enter your phone number',
      name: 'enterPhone',
      desc: '',
      args: [],
    );
  }

  /// `Enter Area`
  String get enterArea {
    return Intl.message(
      'Enter Area',
      name: 'enterArea',
      desc: '',
      args: [],
    );
  }

  /// `Enter Flat No`
  String get enterFlatNo {
    return Intl.message(
      'Enter Flat No',
      name: 'enterFlatNo',
      desc: '',
      args: [],
    );
  }

  /// `Enter P.C`
  String get enterPC {
    return Intl.message(
      'Enter P.C',
      name: 'enterPC',
      desc: '',
      args: [],
    );
  }

  /// `Enter Address Line 1`
  String get enterAddressLine1 {
    return Intl.message(
      'Enter Address Line 1',
      name: 'enterAddressLine1',
      desc: '',
      args: [],
    );
  }

  /// `Enter Address Line 2`
  String get enterAddressLine2 {
    return Intl.message(
      'Enter Address Line 2',
      name: 'enterAddressLine2',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Order ID`
  String get orderId {
    return Intl.message(
      'Order ID',
      name: 'orderId',
      desc: '',
      args: [],
    );
  }

  /// `Your order could not be found!`
  String get orderNotFound {
    return Intl.message(
      'Your order could not be found!',
      name: 'orderNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Items`
  String get items {
    return Intl.message(
      'Items',
      name: 'items',
      desc: '',
      args: [],
    );
  }

  /// `Order Status`
  String get orderStatus {
    return Intl.message(
      'Order Status',
      name: 'orderStatus',
      desc: '',
      args: [],
    );
  }

  /// `Payment Status`
  String get paymentStatus {
    return Intl.message(
      'Payment Status',
      name: 'paymentStatus',
      desc: '',
      args: [],
    );
  }

  /// `Sub Total`
  String get subTotal {
    return Intl.message(
      'Sub Total',
      name: 'subTotal',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Charge`
  String get deliveryCharge {
    return Intl.message(
      'Delivery Charge',
      name: 'deliveryCharge',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discount {
    return Intl.message(
      'Discount',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Order`
  String get cancelOrder {
    return Intl.message(
      'Cancel Order',
      name: 'cancelOrder',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get orderDetails {
    return Intl.message(
      'Order Details',
      name: 'orderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Delivery address`
  String get Shipping {
    return Intl.message(
      'Delivery address',
      name: 'Shipping',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Opening Time`
  String get storeOpenT {
    return Intl.message(
      'Opening Time',
      name: 'storeOpenT',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `All Product`
  String get allProducts {
    return Intl.message(
      'All Product',
      name: 'allProducts',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get reviews {
    return Intl.message(
      'Reviews',
      name: 'reviews',
      desc: '',
      args: [],
    );
  }

  /// `User review not found!`
  String get reviewsNotFound {
    return Intl.message(
      'User review not found!',
      name: 'reviewsNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Payable Amount`
  String get payableAmount {
    return Intl.message(
      'Payable Amount',
      name: 'payableAmount',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Add Address`
  String get addAddress {
    return Intl.message(
      'Add Address',
      name: 'addAddress',
      desc: '',
      args: [],
    );
  }

  /// `Enter promo code`
  String get enterPromoCode {
    return Intl.message(
      'Enter promo code',
      name: 'enterPromoCode',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Applied`
  String get applied {
    return Intl.message(
      'Applied',
      name: 'applied',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkOut {
    return Intl.message(
      'Checkout',
      name: 'checkOut',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your promo code!`
  String get pEnterPromoCode {
    return Intl.message(
      'Please enter your promo code!',
      name: 'pEnterPromoCode',
      desc: '',
      args: [],
    );
  }

  /// `Your Cart is Empty`
  String get yourCartIsEmpty {
    return Intl.message(
      'Your Cart is Empty',
      name: 'yourCartIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Go To Home`
  String get goToHome {
    return Intl.message(
      'Go To Home',
      name: 'goToHome',
      desc: '',
      args: [],
    );
  }

  /// `Write here any additional info`
  String get additionalInfo {
    return Intl.message(
      'Write here any additional info',
      name: 'additionalInfo',
      desc: '',
      args: [],
    );
  }

  /// `To Be Paid`
  String get toBePaid {
    return Intl.message(
      'To Be Paid',
      name: 'toBePaid',
      desc: '',
      args: [],
    );
  }

  /// `Cash On Delivery`
  String get cashOnDelivery {
    return Intl.message(
      'Cash On Delivery',
      name: 'cashOnDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Credit Or Debit Card`
  String get card {
    return Intl.message(
      'Credit Or Debit Card',
      name: 'card',
      desc: '',
      args: [],
    );
  }

  /// `Place Order`
  String get placeOrder {
    return Intl.message(
      'Place Order',
      name: 'placeOrder',
      desc: '',
      args: [],
    );
  }

  /// `Please select the payment method!`
  String get selectPaymentMethod {
    return Intl.message(
      'Please select the payment method!',
      name: 'selectPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Your order has been received`
  String get order_received {
    return Intl.message(
      'Your order has been received',
      name: 'order_received',
      desc: '',
      args: [],
    );
  }

  /// `Your order ID is`
  String get yourOrderID {
    return Intl.message(
      'Your order ID is',
      name: 'yourOrderID',
      desc: '',
      args: [],
    );
  }

  /// `You will receive a confirmation message with your order details`
  String get orderDialogDes {
    return Intl.message(
      'You will receive a confirmation message with your order details',
      name: 'orderDialogDes',
      desc: '',
      args: [],
    );
  }

  /// `Continue Shopping`
  String get continueShopping {
    return Intl.message(
      'Continue Shopping',
      name: 'continueShopping',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get logutConfirmation {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'logutConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Okay`
  String get okay {
    return Intl.message(
      'Okay',
      name: 'okay',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Out Of Stock`
  String get outOfStock {
    return Intl.message(
      'Out Of Stock',
      name: 'outOfStock',
      desc: '',
      args: [],
    );
  }

  /// `Recover Password`
  String get recoverPassword {
    return Intl.message(
      'Recover Password',
      name: 'recoverPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter the email or phone number that you used when registering to recover your password. You will receive an OTP code`
  String get passRecoverDes {
    return Intl.message(
      'Enter the email or phone number that you used when registering to recover your password. You will receive an OTP code',
      name: 'passRecoverDes',
      desc: '',
      args: [],
    );
  }

  /// `Send OTP`
  String get sendOtp {
    return Intl.message(
      'Send OTP',
      name: 'sendOtp',
      desc: '',
      args: [],
    );
  }

  /// ` Enter OTP`
  String get enterOTP {
    return Intl.message(
      ' Enter OTP',
      name: 'enterOTP',
      desc: '',
      args: [],
    );
  }

  /// `We sent OTP code to`
  String get verifyOTPDes {
    return Intl.message(
      'We sent OTP code to',
      name: 'verifyOTPDes',
      desc: '',
      args: [],
    );
  }

  /// `Confirm OTP`
  String get confirmOTP {
    return Intl.message(
      'Confirm OTP',
      name: 'confirmOTP',
      desc: '',
      args: [],
    );
  }

  /// `Resend code in`
  String get resend {
    return Intl.message(
      'Resend code in',
      name: 'resend',
      desc: '',
      args: [],
    );
  }

  /// `sec`
  String get sec {
    return Intl.message(
      'sec',
      name: 'sec',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect pin code`
  String get incorrectPin {
    return Intl.message(
      'Incorrect pin code',
      name: 'incorrectPin',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message(
      'Resend Code',
      name: 'resendCode',
      desc: '',
      args: [],
    );
  }

  /// `Create New Password`
  String get createNewPass {
    return Intl.message(
      'Create New Password',
      name: 'createNewPass',
      desc: '',
      args: [],
    );
  }

  /// `Type and confirm a secure new password for your account`
  String get newPassDes {
    return Intl.message(
      'Type and confirm a secure new password for your account',
      name: 'newPassDes',
      desc: '',
      args: [],
    );
  }

  /// `Set Password`
  String get setPass {
    return Intl.message(
      'Set Password',
      name: 'setPass',
      desc: '',
      args: [],
    );
  }

  /// `Whoops!!`
  String get whoops {
    return Intl.message(
      'Whoops!!',
      name: 'whoops',
      desc: '',
      args: [],
    );
  }

  /// `No Internet connection was found. Check your connection or try again.`
  String get noInternetDes {
    return Intl.message(
      'No Internet connection was found. Check your connection or try again.',
      name: 'noInternetDes',
      desc: '',
      args: [],
    );
  }

  /// `Check Internet Connection`
  String get checkInternetConnection {
    return Intl.message(
      'Check Internet Connection',
      name: 'checkInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure?`
  String get areYouSure {
    return Intl.message(
      'Are you sure?',
      name: 'areYouSure',
      desc: '',
      args: [],
    );
  }

  /// `This action cannot be undone.All values associated with this field will be lost.`
  String get accountDeleteDes {
    return Intl.message(
      'This action cannot be undone.All values associated with this field will be lost.',
      name: 'accountDeleteDes',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'bn'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
