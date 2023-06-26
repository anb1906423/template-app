import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../controller/notifi_controlle.dart';
import '../model/user_model.dart';

class UserService extends GetxService {
  final NotifiController _notifiController = Get.put(NotifiController());
  final GetStorage _storage = GetStorage();

  final box = GetStorage();
  UserModel? currentUser;

  UserService() {
    final userFromStorage = getUserFromStorage();
    if (userFromStorage != null) {
      currentUser = userFromStorage;
    }
  }

  Future<void> userRegister(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(API.userRegister()),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        Get.toNamed("/login");
        _notifiController.showNotifi(
          "Đăng ký tài khoản thành công",
          Colors.green,
          Colors.white,
        );
      } else {
        _notifiController.showNotifi(
          "Địa chỉ email đã được sử dụng!",
          Colors.red,
          Colors.white,
        );
        throw Exception('Failed to register user');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<UserModel> userLogin(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(API.userLogin()),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      // user@gmail.com
      // 0819222273
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final user = UserModel.fromJson(jsonData);
        // setCurrentUser(user, jsonData['user']['_id']);
        box.write('token', jsonData['token']);
        return user;
      } else {
        throw Exception('Failed to login');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<UserModel> getDetailUser(String userId) async {
    try {
      final response = await http.get(
        Uri.parse(API.getUserDetail(userId)),
        headers: {
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final user = UserModel.fromJson(jsonData['user']);
        // print(jsonData['user']['_id']);
        print("get user detail successfully");
        setCurrentUser(user, jsonData['user']['_id']);
        return user;
      } else {
        throw Exception('Failed to get user detail');
      }
    } catch (error) {
      throw error;
    }
  }

  bool isLoggedIn() {
    final token = box.read('token');
    return token != null && token.isNotEmpty;
  }

  void deleteUserData() {
    box.remove('currentUser');
  }

  void logout() {
    box.remove('token');
    deleteUserData();
    currentUser = null;
    _storage.remove('carts');
  }

  void setCurrentUser(UserModel user, String userId) {
    user.userId = userId;
    currentUser = user;
    box.write('currentUser', user.toJson());
  }

  UserModel? getCurrentUser() {
    return currentUser;
  }

  UserModel? getUserFromStorage() {
    final userData = box.read('currentUser');
    if (userData != null) {
      return UserModel.fromJson(userData);
    } else {
      return null;
    }
  }

  Future<void> updateUserProfile(UserModel updatedUser) async {
    try {
      final response = await http.put(
        Uri.parse(API.updateUserProfile(updatedUser.userId)),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode(updatedUser.toJson()),
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        // Cập nhật thông tin người dùng thành công
        setCurrentUser(updatedUser, updatedUser.userId);
        Get.offAllNamed("/profile");
        _notifiController.showNotifi(
          "Cập nhập thông tin thành công",
          Colors.green,
          Colors.white,
        );
      } else {
        throw Exception('Failed to update user information');
      }
    } catch (error) {
      _notifiController.showNotifi(
        "Đã xảy ra lỗi khi cập nhật thông tin!!",
        Colors.red,
        Colors.white,
      );
      throw error;
    }
  }
}
