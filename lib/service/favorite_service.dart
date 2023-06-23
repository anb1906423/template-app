import 'dart:convert';

import 'package:get/get.dart';
import '../config/api_config.dart';
import 'package:http/http.dart' as http;

import '../widget/favorite.dart';
import '../widget/product.dart';
import '../model/favorite_model.dart';

class FavoriteService extends GetxService {


  Future<List<FavoriteModel>> getFavoritesByUserId(String userId) async {
    // Gửi yêu cầu HTTP để lấy danh sách yêu thích của người dùng theo ID
    final response =
        await http.get(Uri.parse(API.getFavoritesByUserId(userId)));
    print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final List<FavoriteModel> favorites = [];

      for (var item in jsonData) {
        final favorite = FavoriteModel.fromJson(item);
        favorites.add(favorite);
      }

      return favorites;
    } else {
      // Xử lý lỗi nếu không thành công
      print("failed");
      throw Exception('Failed to load favorites');
    }
  }

  Future<void> addToFavorites(String userId, String productId) async {
    final Map<String, String> data = {
      'userId': userId,
      'productId': productId,
    };

    final response = await http.post(
      Uri.parse(API.addToFavorites(userId, productId)),
      body: json.encode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add to favorites');
    }
  }

  Future<void> removeFavorites(String userId, String productId) async {
    try {
      final Map<String, String> data = {
        'userId': userId,
        'productId': productId,
      };
      final response = await http.delete(
        Uri.parse(API.removeFavorite(userId, productId)),
        body: json.encode(data),
        headers: {'Content-Type': 'application/json'},
      );
      print(response.statusCode);

      if (response.statusCode != 200) {
        throw Exception('Failed to remove from favorites');
      }
    } catch (e) {
      print(e);
    }
  }

  // Future<void> removeFavorite(String userId, String productId) async {
  //   final response = await http.delete(
  //     Uri.parse(API.removeFavorite(userId, productId)),
  //     headers: {'Content-Type': 'application/json'},
  //   );

  //   if (response.statusCode != 200) {
  //     throw Exception('Failed to remove favorite');
  //   }
  // }


}
