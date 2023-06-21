import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template_app/controller/product_controller.dart';
import 'package:template_app/model/product_model.dart';

import 'notifi_controlle.dart';

class ProductDetailController extends GetxController {
  late final ProductModel? product;

  final ProductController productController = Get.find();
  final NotifiController _notifiController = Get.put(NotifiController());

  @override
  void onInit() {
    super.onInit();

    final String? id = Get.parameters["id"];
    if (id == null) {
      throw "id null";
    }

    product = productController.getProductById(id);
    if (product == null) {
      _notifiController.showNotifi(
        "xin loi, san pham khong ton tai".tr,
        Colors.red,
        Colors.white,
      );
      throw "Không tìm thấy sản phẩm";
    }
  }
  void toggleFavorite() {}
}
