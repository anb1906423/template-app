class API {
  String host = 'http://10.0.2.2:3000';
  static const String baseUrl = 'http://10.0.2.2:3000/api';

  static String getProductList() {
    return '$baseUrl/product/get-all';
  }

  static String getOrderList() {
    return '$baseUrl/order/list';
  }

  static String getOrderDetail(String orderId) {
    return '$baseUrl/order/detail/$orderId';
  }

  static String userRegister() {
    return '$baseUrl/user/registration';
  }

  static String userLogin() {
    return '$baseUrl/user/login';
  }

  static String getUserDetail(String userId) {
    return '$baseUrl/user/detail/$userId';
  }

}