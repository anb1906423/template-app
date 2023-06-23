import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template_app/model/order_model.dart';
import 'package:template_app/service/order_service.dart';

import '../model/cart_model.dart';
import '../service/user_service.dart';
import 'cart_controller.dart';
import 'notifi_controlle.dart';

class OrderController extends GetxController {
  final UserService userService = UserService();
  final RxList<Order> orders = <Order>[].obs;
  final OrderService _orderService = OrderService();
  final CartController _cartController = Get.put(CartController());
  final NotifiController _notifiController = Get.put(NotifiController());

  @override
  void onInit() {
    super.onInit();
    getOrdersByUserId();
  }

  Future<void> getOrdersByUserId() async {
    try {
      final responseData = await OrderService.getOrdersByUserId(
          userService.currentUser?.userId ?? "");
        orders.assignAll(responseData);
    } catch (error) {
      // Handle exceptions
      print(error);
    }
  }

  Future<void> submitOrder(List<CartItem> cartItems) async {
    try {
      final dynamic response = await _orderService.createOrder(
        userId: userService.currentUser?.userId ?? "",
        items: cartItems,
        phoneNumber: userService.currentUser?.phoneNumber ?? "",
        address: userService.currentUser?.address ?? "",
        email: userService.currentUser?.email ?? "",
        customerName: userService.currentUser?.fullName ?? "",
      );
      _cartController.emptyCart();
      getOrdersByUserId();
      _notifiController.showNotifi(
        "Đặt hàng thành công",
        Colors.green,
        Colors.white,
      );
      Get.toNamed('/home');
    } catch (error) {
      print(error);
    }
  }
}
