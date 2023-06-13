import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../model/product_model.dart';

class ProductService extends GetxService {
  Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(Uri.parse(API.getProductList()));
    if (response.statusCode == 200) {
      final dynamic responseData = json.decode(response.body);

      if (responseData['products'] is List) {
        final List<dynamic> data = responseData['products'];
        return data.map((item) => ProductModel.fromJson(item)).toList();
      } else {
        print('Invalid response data format');
        throw Exception('Invalid response data format');
      }
    } else {
      print('Failed to fetch products');
      throw Exception('Failed to fetch products');
    }
  }
}
