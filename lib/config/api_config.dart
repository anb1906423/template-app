class API {
  String host = 'http://10.0.2.2:3000';
  static const String baseUrl = 'http://10.0.2.2:3000/api';

  static String getProductList() {
    return '$baseUrl/product/get-all';
  }

  static String getProductDetail(String productId) {
    return '$baseUrl/product/detail/$productId';
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

  static String addToCart(String userId, String productId) {
    return '$baseUrl/cart/add';
  }

  static String updateCartItemQuantity() {
    return '$baseUrl/cart/update';
  }

  static String getCart(String userId) {
    return '$baseUrl/cart/detail/$userId';
  }
  static String emptyCart(String user_id) {
    return '$baseUrl/cart/empty/$user_id';
  }

  static String removeFromCart(String user_id, String product_id) {
    return '$baseUrl/cart/delete/$user_id/$product_id';
  }

  static String getUserDetail(String userId) {
    return '$baseUrl/user/detail/$userId';
  }

  static String updateUserProfile(String userId) {
    return '$baseUrl/user/update/$userId';
  }

   static String createOrder() {
    return '$baseUrl/order/create';
  }

  static String getOrdersByUserId(String userId) {
    return '$baseUrl/order/list/$userId';
  }

   static String getOrderDetails(String orderId) {
    return '$baseUrl/order/detail/$orderId';
  }

  static String getFavoritesByUserId(String userId) {
    return '$baseUrl/favorite/user/$userId';
  }

  static String addToFavorites(String userId, String productId) {
    return '$baseUrl/favorite/add/$productId/$userId';
  }

  static String removeFavorite(String userId, String productId) {
    return '$baseUrl/favorite/remove/$productId/$userId';
  }
}

