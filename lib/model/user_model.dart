import 'package:get/get.dart';

class UserModel {
  String email;
  String password;
  String fullName;
  String phoneNumber;
  String address;

  UserModel({
    required this.email,
    required this.password,
    this.fullName = '',
    this.phoneNumber = '',
    this.address = '',
  });

  UserModel copyWith({
    String? email,
    String? password,
    String? fullName,
    String? phoneNumber,
    String? address,
  }) {
    return UserModel(
      email: email ?? this.email,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "address": address,
    };
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json["email"],
      password: json["password"],
      fullName: json["fullName"] ?? 'chua cap nhat'.tr,
      phoneNumber: json["phoneNumber"] ?? 'chua cap nhat'.tr,
      address: json["address"] ?? 'chua cap nhat'.tr,
    );
  }
}
