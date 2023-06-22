import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template_app/model/order_model.dart';
import 'package:template_app/service/order_service.dart';

import '../service/user_service.dart';

class OrderController extends GetxController {
  final UserService userService = UserService();
  final RxList<Order> orders = <Order>[].obs;

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

}


// Future<void> createOrder(String userId, String productId, String price,
//       String productName, int quantity, String tempValue) async {
//     final List<OrderItem> tempOrders = List<OrderItem>.from(orders);
//     try {
//       String userId = userService.currentUser?.userId ?? "";
//       await OrderService.createOrder(userId, productId, price, productName,quantity, tempValue);
//       final OrderItem newOrderItem = OrderItem(
//         // Tạo đối tượng OrderItem mới với các thông tin tương ứng
//         productId: productId,
//         price: price,
//         quantity: quantity,
//         productName: '',
//         tempValue: '',
//       );
//       tempOrders.add(newOrderItem); // Thêm sản phẩm mới vào danh sách tạm thời
//       orders.assignAll(tempOrders); // Gán danh sách tạm thời vào `carts`
//       fetchOrderDetails();
//       print('Product added to cart');
//     } catch (error) {
//       print('Failed to add product to cart');
//     }
//   }


