import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:template_app/model/order_model.dart';
import 'dart:convert';

import '../config/api_config.dart';
import '../model/cart_model.dart';

class OrderService extends GetxService {
  Future<Map<String, dynamic>> createOrder({
    required String userId,
    required List<CartItem> items,
    required String phoneNumber,
    required String address,
    required String email,
    required String customerName,
  }) async {
    try {
      final itemData = items.map((item) {
        return {
          'product_id': item.productId,
          'price': item.price,
          'title': item.title,
          'imageUrl': item.imageUrl,
          'quantity': item.quantity,
        };
      }).toList();

      final orderData = {
        'user_id': userId,
        'items': itemData,
        'phoneNumber': phoneNumber,
        'address': address,
        'email': email,
        'customerName': customerName,
      };
      final response = await http.post(
        Uri.parse(API.createOrder()),
        body: json.encode(orderData),
        headers: {'Content-Type': 'application/json'},
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        return {
          'message': 'Order created',
          'order': responseData['order'],
        };
      } else {
        throw Exception(responseData['error']);
      }
    } catch (error) {
      print(error);
      throw Exception('Error occurred while creating order');
    }
  }

  static Future<List<Order>> getOrdersByUserId(String userId) async {
    try {
      final response = await http.get(Uri.parse(API.getOrdersByUserId(userId)));
      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // final Map<String, dynamic> jsonResponse =
        //     json.decode(response.body) as Map<String, dynamic>;
        final List<dynamic> ordersData =
            responseData['orders'] as List<dynamic>;
        return ordersData
            .map((order) => Order.fromJson(order as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(responseData['error']);
      }
    } catch (error) {
      throw Exception('$error');
    }
  }
}
