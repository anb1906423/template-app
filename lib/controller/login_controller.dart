import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/user_model.dart';
import '../service/user_service.dart';

class LoginController extends GetxController {
  final UserService _userService = Get.put(UserService());
  RxString email = RxString('');
  String get emailValue => email.value;
  set emailValue(String value) => email.value = value;

  RxString password = RxString('');
  String get passwordValue => password.value;
  set passwordValue(String value) => password.value = value;

  Future<void> loginUser(String email, String password) async {
    // final email = emailController.text;
    // final password = passwordController.text;
    print(email);
    print(password);
    try {
      UserModel user = await _userService.userLogin(email, password);
      // Xử lý dữ liệu user sau khi đăng nhập thành công
      print("login successfully");
    } catch (error) {
      // Xử lý lỗi khi đăng nhập thất bại
      print("login failed");
      print(error);
    }
  }
}
