import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotifiController extends GetxController {
  void showNotifi(String content, Color bgColor, Color colorText) {
    Get.snackbar(
      'Thông báo',
      content,
      duration: Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      backgroundColor: bgColor,
      colorText: colorText,
    );
  }
}
