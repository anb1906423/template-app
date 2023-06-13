import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/user_model.dart';
import '../service/user_service.dart';

class UserController extends GetxController {
  final UserService _userService = Get.find<UserService>();

  Rx<UserModel?> user = Rx<UserModel?>(null);
  UserModel? get userValue => user.value;
  set userValue(UserModel? value) => user.value = value;

  @override
  void onInit() {
    getUserDetail(_userService.currentUser?.userId ?? "");
    super.onInit();
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
}
