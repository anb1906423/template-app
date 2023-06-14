import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../model/user_model.dart';
import '../service/user_service.dart';
import 'notifi_controlle.dart';
import 'user_controller.dart';

class LoginController extends GetxController {
  final UserService _userService = Get.put(UserService());
  final UserController _userController = Get.put(UserController());
  final NotifiController _notifiController = Get.put(NotifiController());
  RxString email = RxString('');
  String get emailValue => email.value;
  set emailValue(String value) => email.value = value;

  RxString password = RxString('');
  String get passwordValue => password.value;
  set passwordValue(String value) => password.value = value;

  Future<void> loginUser(String email, String password) async {
    try {
      UserModel user = await _userService.userLogin(email, password);
      // Xử lý dữ liệu user sau khi đăng nhập thành công
      UserModel updatedUser = user.copyWith(
        userId: user.userId,
        email: user.email,
        fullName: user.fullName,
        phoneNumber: user.phoneNumber,
        address: user.address,
      );
      // Lưu thông tin người dùng đã đăng nhập vào currentUser
      _userService.setCurrentUser(updatedUser, user.userId);
      _userController.getUserDetail(user.userId);
      print("login successfully");
      if (user != null) {
        // Đăng nhập thành công
        Get.toNamed("/home");
        _notifiController.showNotifi(
          "Đăng nhập thành công",
          Colors.green,
          Colors.white,
        );
      }
    } catch (error) {
      // Xử lý lỗi khi đăng nhập thất bại
      print("login failed");
      print(error);
      _notifiController.showNotifi(
        "Thông tin tài khoản hoặc mật khẩu không chính xác",
        Colors.red,
        Colors.white,
      );
    }
  }
}
