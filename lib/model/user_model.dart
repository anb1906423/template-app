import 'package:get/get.dart';

class UserModel {
  String userId;
  String email;
  String? fullName;
  String? phoneNumber;
  String? address;
  String token;

  UserModel({
    required this.userId,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.address,
    required this.token,
  });

  UserModel copyWith({
    String? userId,
    String? email,
    String? fullName,
    String? phoneNumber,
    String? address,
    String? token,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "email": email,
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "address": address,
      "token": token,
    };
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json["userId"] ?? "",
      email: json["email"],
      token: json["token"] ?? '',
      fullName: json["fullName"],
      phoneNumber: json["phoneNumber"],
      address: json["address"],
    );
  }
}
