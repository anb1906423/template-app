import 'package:get/get.dart';
import 'package:template_app/controller/cart_controller.dart';
import 'package:template_app/controller/checkout_controller.dart';
import 'package:template_app/controller/history_controller.dart';
import 'package:template_app/controller/product_detail_controller.dart';
import 'package:template_app/controller/product_controller.dart';
import 'package:template_app/controller/register_controller.dart';
import 'package:template_app/controller/setting_language_controller.dart';

import '../controller/login_controller.dart';
import '../controller/notifi_controlle.dart';
import '../controller/user_controller.dart';
import '../service/user_service.dart';

class AllBinding extends Bindings {
  final UserService _userService = Get.put(UserService());

  @override
  void dependencies() {
    Get.lazyPut(() => ProductController());
    Get.lazyPut(() => ProductDetailController());
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => CheckoutController());
    Get.lazyPut(() => HistoryController());
    Get.lazyPut(() => SettingLanguageController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => NotifiController());

    /// more binding here
  }
}
