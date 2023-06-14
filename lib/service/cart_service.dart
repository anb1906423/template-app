import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/api_config.dart';

class CartService extends GetxService {
  static Future<void> addToCart(
      String userId, String productId, int quantity, String price) async {
    try {
      final response = await http.post(
        Uri.parse(API.addToCart()),
        body: json.encode({
          'user_id': userId,
          'product_id': productId,
          'quantity': quantity,
          'price': price,
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
      throw Exception('Error occurred while adding product to cart');
    }
  }

  // static Future<void> updateCartItemQuantity(
  //     String userId, String productId, int quantity) async {
  //   try {
  //     final response = await http.put(
  //       Uri.parse(API.u()),
  //       body: json.encode({
  //         'user_id': userId,
  //         'product_id': productId,
  //         'quantity': quantity,
  //       }),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //     );
  //     final responseData = json.decode(response.body);
  //     if (response.statusCode == 200) {
  //       print(responseData['message']);
  //     } else {
  //       throw Exception(responseData['error']);
  //     }
  //   } catch (error) {
  //     throw Exception('Error occurred while updating cart item quantity');
  //   }
  // }

  static Future<void> removeCartItem(String user_id, String product_id) async {
    try {
      final response = await http.delete(Uri.parse(API.removeFromCart(user_id, product_id)));
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
        return responseData['cart'];
      } else {
        throw Exception(responseData['error']);
      }
    } catch (error) {
      throw Exception('Error occurred while fetching cart details');
    }
  }
}