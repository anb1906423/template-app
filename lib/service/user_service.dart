import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../model/user_model.dart';

class UserService extends GetxService {
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
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final user = UserModel.fromJson(jsonData);
        return user;
      } else {
        throw Exception('Failed to login');
      }
    } catch (error) {
      throw error;
    }
  }
}
