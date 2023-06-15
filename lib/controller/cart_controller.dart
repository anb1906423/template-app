import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/cart_item_model.dart';
import '../service/cart_service.dart';
import '../service/user_service.dart';
import 'user_controller.dart';

class CartController extends GetxController {
  final UserService _userService = Get.put(UserService());

  RxList<CartItem> carts = <CartItem>[].obs; // Trường carts

  Future<void> addToCart(
      String productId, int quantity, String price, BuildContext context) async {
    try {
      String userId = _userService.currentUser?.userId ?? "";
      await CartService.addToCart(userId, productId, quantity, price);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product added to cart')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add product to cart')),
      );
    }
  }

  // Future<void> updateCartItemQuantity(
  //     String productId, int quantity, BuildContext context) async {
  //   try {
  //     await CartService.updateCartItemQuantity(userId, productId, quantity);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Cart item quantity updated')),
  //     );
  //   } catch (error) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to update cart item quantity')),
  //     );
  //   }
  // }

  Future<void> removeCartItem(
      String productId, BuildContext context) async {
    try {
      await CartService.removeCartItem(_userService.currentUser?.userId ?? "", productId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cart item removed')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to remove cart item')),
      );
    }
  }

  Future<Map<String, dynamic>> getCartDetails() async {
    try {
      return await CartService.getCartDetails(_userService.currentUser?.userId ?? "");
    } catch (error) {
      throw Exception('Failed to fetch cart details');
    }
  }
}
