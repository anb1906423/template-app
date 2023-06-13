import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../model/user_model.dart';

class UserService extends GetxService {
  final box = GetStorage();
  UserModel? currentUser;

  UserService() {
    final userFromStorage = getUserFromStorage();
    if (userFromStorage != null) {
      currentUser = userFromStorage;
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
        setCurrentUser(user);
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
        setCurrentUser(user);
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
  }

  void setCurrentUser(UserModel user) {
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
}
