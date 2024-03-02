import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerymart/config/hive_contants.dart';
import 'package:grocerymart/features/cart/model/hive_cart_model.dart';
import 'package:grocerymart/features/menu/model/user_address.dart';
import 'package:grocerymart/service/hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  final Ref ref;
  HiveService(this.ref);

  // save data to the local storage

  // save access token
  Future saveUserAuthToken({required String authToken}) async {
    final authBox = await Hive.openBox(AppHSC.authBox);
    authBox.put(AppHSC.authToken, authToken);
  }

  // remove access token
  Future removeUserAuthToken() async {
    final authBox = await Hive.openBox(AppHSC.authBox);
    authBox.delete(AppHSC.authToken);
  }

  // save user information
  Future saveUserInfo({required User userInfo}) async {
    final userBox = await Hive.openBox(AppHSC.userBox);
    userBox.put(AppHSC.userInfo, userInfo.toMap());
  }

  // save default delivery address
  Future saveDeliveryAddress({required UserAddress userAddress}) async {
    final addressBox = await Hive.openBox(AppHSC.deliveryAddressBox);
    addressBox.put(AppHSC.deliveryAddress, userAddress.toMap());
  }

  // remove user data
  Future removeUserData() async {
    final userBox = await Hive.openBox(AppHSC.userBox);
    userBox.clear();
  }

  // remove deliveryAddress
  Future removeDeliveryAddress() async {
    final addressBox = await Hive.openBox(AppHSC.deliveryAddressBox);
    addressBox.clear();
  }

  // remove cart items
  Future removeCartITems() async {
    final cartBox = await Hive.openBox<HiveCartModel>(AppHSC.cartBox);
    cartBox.clear();
  }

  // save the first open status
  Future setFirstOpenValue({required bool value}) async {
    final appSettingsBox = await Hive.openBox(AppHSC.appSettingsBox);
    appSettingsBox.put(AppHSC.firstOpen, value);
  }

  // save the first open status
  Future isDarkTheme({required bool value}) async {
    final appSettingsBox = await Hive.openBox(AppHSC.appSettingsBox);
    appSettingsBox.put(AppHSC.isDarkTheme, value);
  }

  Future<bool> getTheme() async {
    final Box box = await Hive.openBox(AppHSC.appSettingsBox);
    final themeData = box.get(AppHSC.isDarkTheme);
    return themeData;
  }
// get data from local storge

// get user auth token
  Future<String?> getAuthToken() async {
    final authBox = await Hive.openBox(AppHSC.authBox);
    final authToken = await authBox.get(AppHSC.authToken);
    if (authToken != null) {
      return authToken;
    }
    return null;
  }

// get user information
  Future<User?> getUserInfo() async {
    final userBox = await Hive.openBox(AppHSC.userBox);
    Map<dynamic, dynamic>? userInfo = userBox.get(AppHSC.userInfo);
    if (userInfo != null) {
      // Convert Map<dynamic, dynamic> to Map<String, dynamic>
      Map<String, dynamic> userInfoStringKeys =
          userInfo.cast<String, dynamic>();
      User user = User.fromMap(userInfoStringKeys);
      return user;
    }
    return null;
  }

// get user first open status
  Future<bool?> getUserFirstOpenStatus() async {
    final appSettingsBox = await Hive.openBox(AppHSC.appSettingsBox);
    final status = appSettingsBox.get(AppHSC.firstOpen);
    if (status != null) {
      return status;
    }
    return false;
  }

  Future<List<dynamic>?> loadTokenAndUser() async {
    final firstOpenStatus = await getUserFirstOpenStatus();
    final authToken = await getAuthToken();
    final user = await getUserInfo();

    return [firstOpenStatus, authToken, user];
  }

  Future<bool> removeAllData() async {
    try {
      await removeUserAuthToken();
      await removeDeliveryAddress();
      await removeCartITems();
      // await removeUserData();
      return true;
    } catch (e) {
      return false;
    }
  }
}

final hiveStorageProvider = Provider((ref) => HiveService(ref));
