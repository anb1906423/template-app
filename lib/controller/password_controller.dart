import 'package:get/get.dart';

class PasswordController extends GetxController {
  RxBool obscureText = true.obs;

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }
}
