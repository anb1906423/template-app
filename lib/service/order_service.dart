import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:template_app/model/order_model.dart';
import 'dart:convert';

import '../config/api_config.dart';

class OrderService extends GetxService {
  static Future<void> createOrder(String userId, String productId, String price,
      String productName, int quantity, String tempValue) async {
    try {
      final response = await http.post(
        Uri.parse(API.createOrder()),
        body: json.encode({
          'user_id': userId,
          'product_id': productId,
          'quantity': quantity,
          'price': price,
          "productName": productName,
          "tempValue": tempValue,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        print(responseData['data']);
      } else {
        throw Exception(responseData['error']);
      }
    } catch (error) {
      throw Exception('Error occurred while creating order');
    }
  }

  static Future<List<Order>> getOrdersByUserId(String userId) async {
    try {
      final response = await http.get(Uri.parse(API.getOrdersByUserId(userId)));
      final responseData = jsonDecode(response.body);
      print("code: ${response.statusCode}");
      print(responseData);
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

  static Future<void> fetchOrderDetails(String orderId) async {
    try {
      final response = await http.get(Uri.parse(API.getOrderDetails(orderId)));
      final responseData = json.decode(response.body);
      print("code: ${response.statusCode}");
      print(responseData);
      if (response.statusCode == 200) {
        return responseData;
      } else {
        throw Exception(responseData['error']);
      }
    } catch (error) {
      throw Exception('Error occurred while fetching order details');
    }
  }
}
