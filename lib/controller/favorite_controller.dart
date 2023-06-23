import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template_app/controller/notifi_controlle.dart';

import '../model/favorite_model.dart';
import '../service/favorite_service.dart';
import '../service/user_service.dart';

class FavoriteController extends GetxController {
  final NotifiController _notifiController = Get.put(NotifiController());
  final FavoriteService _favoriteService = FavoriteService();
  RxList<FavoriteModel> favorites = <FavoriteModel>[].obs;
  final _userService = UserService();


  Future<void> getFavoritesByUserId(String userId) async {
    try {
      final List<FavoriteModel> fetchedFavorites =
          await _favoriteService.getFavoritesByUserId(userId);
      favorites.assignAll(fetchedFavorites);
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> addToFavorites(String userId, String productId) async {
    try {
      await _favoriteService.addToFavorites(userId, productId);
      getFavoritesByUserId(_userService.currentUser?.userId ?? "");
      print('Added to favorites successfully');
      _notifiController.showNotifi(
        "Đã thêm sản phẩm yêu thích thành công",
        Colors.green,
        Colors.white,
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> removeFavorites(String userId, String productId) async {
    try {
      await _favoriteService.removeFavorites(userId, productId);
      getFavoritesByUserId(_userService.currentUser?.userId ?? "");
      _notifiController.showNotifi(
        "Đã xóa sản phẩm yêu thích thành công",
        Colors.green,
        Colors.white,
      );
      print('Removed from favorites successfully');
    } catch (e) {
      print('Error: $e');
    }
  }

  bool isProductFavorite(String userId, String productId) {
    // Kiểm tra xem sản phẩm có trong danh sách yêu thích hay không
    return favorites.any((product) => product.productId == productId);
  }
}
