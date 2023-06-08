import 'package:get/get.dart';
import 'package:template_app/controller/cart_controller.dart';
import 'package:template_app/controller/checkout_controller.dart';
import 'package:template_app/controller/history_controller.dart';
import 'package:template_app/controller/product_detail_controller.dart';
import 'package:template_app/controller/product_controller.dart';
import 'package:template_app/controller/register_controller.dart';
import 'package:template_app/controller/setting_language_controller.dart';

import '../controller/login_controller.dart';

class AllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductController());
    Get.lazyPut(() => ProductDetailController());
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => CheckoutController());
    Get.lazyPut(() => HistoryController());
    Get.lazyPut(() => SettingLanguageController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => RegisterController());

    /// more binding here
  }
}