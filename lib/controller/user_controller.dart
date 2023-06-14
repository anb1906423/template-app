import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/user_model.dart';
import '../service/user_service.dart';
import 'notifi_controlle.dart';

class UserController extends GetxController {
  final NotifiController _notifiController = Get.put(NotifiController());
  final UserService _userService = Get.find<UserService>();

  Rx<UserModel?> user = Rx<UserModel?>(null);
  UserModel? get userValue => user.value;
  set userValue(UserModel? value) => user.value = value;
  RxString email = RxString('');
  String get emailValue => email.value;
  set emailValue(String value) => email.value = value;

  RxString password = RxString('');
  String get passwordValue => password.value;
  set passwordValue(String value) => password.value = value;

  @override
  void onInit() {
    getUserDetail(_userService.currentUser?.userId ?? "");
    super.onInit();
  }

  Future<void> userRegister(String email, String password) async {
    try {
      final user = await _userService.userRegister(email, password);
      
    } catch (error) {
      print('Failed to register user: $error');
    }
  }

  Future<void> getUserDetail(String userId) async {
    try {
      UserModel userDetail = await _userService.getDetailUser(userId);
      user.value = userDetail;
      print(userDetail);
    } catch (error) {
      // Xử lý lỗi khi lấy thông tin người dùng
      print("Failed to get user detail");
      print(error);
    }
  }

  Future<void> updateUserProfile(UserModel updatedUser) async {
    try {
      await _userService.updateUserProfile(updatedUser);
  
    } catch (error) {
      print("Failed to update user information: $error");
    }
  }
}
