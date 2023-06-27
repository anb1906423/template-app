import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/cart_model.dart';
import '../service/cart_service.dart';
import '../service/user_service.dart';

class CartController extends GetxController {
  final GetStorage _storage = GetStorage();
  final UserService _userService = UserService();
  final CartService _cartService = CartService();

  final RxList<CartItem> carts = <CartItem>[].obs;
  final RxString total = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getCartsFromStorage();
    getCartDetails();
    // _storage.remove('carts');
  }

  void getCartsFromStorage() {
    final List<dynamic>? storedCarts = _storage.read<List<dynamic>>('carts');
    if (storedCarts != null) {
      final List<CartItem> cartList = storedCarts
          .map(
              (cartData) => CartItem.fromJson(cartData as Map<String, dynamic>))
          .toList();
      carts.assignAll(cartList);
    }
  }

  void saveCartsToStorage() {
    final List<Map<String, dynamic>> cartList =
        carts.map((cartItem) => cartItem.toJson()).toList();
    _storage.write('carts', cartList);
  }

  Future<void> addToCart(String user_id, String productId, String price,
      String title, String imageUrl,
      {int quantity = 1}) async {
    final List<CartItem> tempCarts = List<CartItem>.from(carts);
    try {
      String userId = _userService.currentUser?.userId ?? "";
      await _cartService.addToCart(userId, productId, price, title, imageUrl,
          quantity: quantity);
      final CartItem newCartItem = CartItem(
        // Tạo đối tượng CartItem mới với các thông tin tương ứng
        productId: productId,
        price: price,
        quantity: quantity,
        title: title,
        imageUrl: imageUrl,
      );
      tempCarts.add(newCartItem); // Thêm sản phẩm mới vào danh sách tạm thời
      carts.assignAll(tempCarts); // Gán danh sách tạm thời vào `carts`
      saveCartsToStorage();
      getCartDetails();
      updateTotal();
      print('Product added to cart');
    } catch (error) {
      print('Failed to add product to cart');
    }
  }

  void updateTotal() {
    double sum = 0;
    for (var cartItem in carts) {
      double price = double.tryParse(cartItem.price) ?? 0;
      int quantity = cartItem.quantity;
      sum += price * quantity;
    }
    total.value = sum.toStringAsFixed(0);
  }

  Future<void> updateCartItemQuantity(
      String userId, String productId, int quantity) async {
    try {
      if (quantity <= 0) {
        await removeCartItem(productId);
      } else {
        await CartService.updateCartItemQuantity(userId, productId, quantity);
        final cartItem = carts.firstWhere((item) => item.productId == productId,
            orElse: () => CartItem(
                  productId: productId,
                  price: '',
                  quantity: 0,
                  title: '',
                  imageUrl: '',
                ));

        cartItem.quantity = quantity;
        updateTotal();
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> removeCartItem(String productId) async {
    try {
      await CartService.removeCartItem(
          _userService.currentUser?.userId ?? "", productId);
      saveCartsToStorage();
      getCartDetails();

      carts.removeWhere((element) => element.productId == productId);

      print("t " + carts.length.toString());
    } catch (error) {
      print('Failed to remove cart item');
    }
  }

  Future<void> getCartDetails() async {
    try {
      final responseData = await CartService.getCartDetails(
          _userService.currentUser?.userId ?? "");
      final cartData = responseData['cart'];
      final cartItems = cartData['items'];
      final cartTotal = cartData['total'];
      print(cartTotal);

      final List<CartItem> cartItemList =
          cartItems.map<CartItem>((item) => CartItem.fromJson(item)).toList();
      carts.assignAll(cartItemList);
      total.value = cartTotal;
      print(cartItemList.length);
      // Lỗi login chưa load giỏ hàng ngay
      saveCartsToStorage();
    } catch (error) {
      // Handle exceptions
      print(error);
    }
  }

  Future<void> emptyCart() async {
    try {
      await CartService.emptyCart(_userService.currentUser?.userId ?? "");
      saveCartsToStorage();
      getCartDetails();
      _storage.remove('carts');
    } catch (error) {
      print('Failed to empty cart item');
    }
  }
}
