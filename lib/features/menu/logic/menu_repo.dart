import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerymart/config/app_constants.dart';
import 'package:grocerymart/features/menu/model/update_profile.dart';
import 'package:grocerymart/features/menu/model/user_address.dart';
import 'package:grocerymart/service/hive_logic.dart';
import 'package:grocerymart/service/hive_model.dart';
import 'package:grocerymart/utils/api_client.dart';

class MenuRepo {
  final Ref ref;
  MenuRepo(this.ref);

  Future<String?> updateProfileInfo({
    required UpdateProfile profileInfo,
    required File? file,
  }) async {
    FormData formData = FormData.fromMap({
      'profile_photo': file != null
          ? await MultipartFile.fromFile(file.path,
              filename: 'profile_photo.jpg')
          : null,
      ...profileInfo.toMap(),
    });
    final response = await ref.read(apiClientProvider).post(
          AppConstant.updateUserInfo,
          data: formData,
        );
    if (response.statusCode == 200) {
      final message = response.data['message'];
      final userInfo = User.fromMap(response.data['data']['user']);
      ref.read(hiveStorageProvider).saveUserInfo(userInfo: userInfo);
      return message;
    }
    return null;
  }

  Future<String?> manageUserAddress({required UserAddress userAddress}) async {
    final response = await ref.read(apiClientProvider).post(
          AppConstant.manageAddress,
          data: userAddress.toMap(),
        );
    if (response.statusCode == 200) {
      final message = response.data['message'];
      return message;
    }
    return null;
  }

  Future<List<UserAddress>> getUserAddresses() async {
    final response = await ref.read(apiClientProvider).get(
          AppConstant.getUserAddresses,
        );
    if (response.statusCode == 200) {
      List<dynamic> addressesData = response.data['data']['addresses'];
      List<UserAddress> userAddresses =
          addressesData.map((address) => UserAddress.fromMap(address)).toList();
      if (userAddresses.isNotEmpty) {
        ref
            .read(hiveStorageProvider)
            .saveDeliveryAddress(userAddress: userAddresses.first);
      }

      return userAddresses.isEmpty ? [] : userAddresses;
    }
    return [];
  }
}

final menuRepo = Provider((ref) => MenuRepo(ref));
