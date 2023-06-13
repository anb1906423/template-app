import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../model/cart_item_model.dart';

class CartService extends GetxService {
//  Future<void> addToCart(int productId, double price, int quantity) async {
//   var url = API.addToCart();
//   var body = json.encode({
//     'product_id': productId,
//     'price': price,
//     'quantity': quantity
//   });
//   var response = await http.post(Uri.parse(url),
//       headers: {'Content-Type': 'application/json'}, body: body);

//   if (response.statusCode == 200) {
//     var responseData = json.decode(response.body);
//     // Xử lý kết quả trả về ở đây
//     var cartItem = CartItemModel.fromJson(responseData);
//     print('Added to cart: ${cartItem.title}');
//   } else {
//     // Xử lý lỗi tại đây
//     print(response.reasonPhrase);
//   }
// }

// Future<List<CartItemModel>> getCart() async {
//   var url = API.getCart();
//   var response = await http.get(Uri.parse(url));

//   if (response.statusCode == 200) {
//     var responseData = json.decode(response.body);
//     // Xử lý kết quả trả về ở đây
//     List<CartItemModel> cartItems = [];
//     for (var data in responseData) {
//       cartItems.add(CartItemModel.fromJson(data));
//     }
//     return cartItems;
//   } else {
//     // Xử lý lỗi tại đây
//     print(response.reasonPhrase);
//     return [];
//   }
// }

// Future<void> removeFromCart(String cartId) async {
//   var url = API.removeFromCart(cartId);
//   var response = await http.delete(Uri.parse(url));
//   if (response.statusCode == 200) {
//     var responseData = json.decode(response.body);
//     // Xử lý kết quả trả về ở đây
//     var cartItem = CartItemModel.fromJson(responseData);
//     print('Removed from cart: ${cartItem.title}');
//   } else {
//     // Xử lý lỗi tại đây
//     print(response.reasonPhrase);
//   }
// }

  Future<List<CartItemModel>> fetchCartItems() async {
    final response = await http.get(Uri.parse(API.getCart()));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((item) => CartItemModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load cart items');
    }
  }

  Future<void> addCartItem(CartItemModel item) async {
    final response = await http.post(Uri.parse(API.addToCart()),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(item.toJson()));
    if (response.statusCode != 200) {
      throw Exception('Failed to add item to cart');
    }
  }

  Future<void> removeCartItem(String cartId) async {
    var url = API.removeFromCart(cartId);
    var response = await http.delete(Uri.parse(url));
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      // Xử lý kết quả trả về ở đây
      print(responseData);
    } else {
      // Xử lý lỗi tại đây
      print(response.reasonPhrase);
      throw Exception('Failed to remove item from cart');
    }
  }
}
