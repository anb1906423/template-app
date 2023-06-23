import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/api_config.dart';
import '../controller/notifi_controlle.dart';

class CartService extends GetxService {
  final NotifiController _notifiController = Get.put(NotifiController());

  Future<void> addToCart(String userId, String productId, String price,
      String title, String imageUrl,
      {int quantity = 1}) async {
    try {
      final response = await http.post(
        Uri.parse(API.addToCart(userId, productId)),
        body: json.encode({
          'user_id': userId,
          'product_id': productId,
          'quantity': quantity,
          'price': price,
          "title": title,
          "imageUrl": imageUrl,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        _notifiController.showNotifi(
          "${title} đã được thêm vào giỏ hàng",
          Colors.green,
          Colors.white,
        );
        print(responseData['message']);
      } else {
        throw Exception(responseData['error']);
      }
    } catch (error) {
      throw Exception('Error occurred while adding product to cart');
    }
  }

  static Future<void> updateCartItemQuantity(
      String userId, String productId, int quantity) async {
    try {
      final response = await http.put(
        Uri.parse(API.updateCartItemQuantity()),
        body: json.encode({
          'user_id': userId,
          'product_id': productId,
          'quantity': quantity,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        print(responseData['message']);
      } else {
        throw Exception(responseData['error']);
      }
    } catch (error) {
      throw Exception('Error occurred while updating cart item quantity');
    }
  }

  static Future<void> removeCartItem(String user_id, String product_id) async {
    try {
      final response =
          await http.delete(Uri.parse(API.removeFromCart(user_id, product_id)));
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        print(responseData['message']);
      } else {
        throw Exception(responseData['error']);
      }
    } catch (error) {
      throw Exception('Error occurred while removing cart item');
    }
  }

  static Future<Map<String, dynamic>> getCartDetails(String userId) async {
    try {
      final response = await http.get(Uri.parse(API.getCart(userId)));
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        // return responseData['cart'] as Map<String, dynamic>;
        return responseData;
      } else {
        throw Exception(responseData['error']);
      }
    } catch (error) {
      throw Exception('Error occurred while fetching cart details');
    }
  }

  static Future<void> emptyCart(String user_id) async {
    try {
      final response = await http.delete(Uri.parse(API.emptyCart(user_id)));
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        print(responseData['message']);
      } else {
        throw Exception(responseData['error']);
      }
    } catch (error) {
      throw Exception('Error occurred while empty cart');
    }
  }
}
