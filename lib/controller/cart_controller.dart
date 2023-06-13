import 'package:get/get.dart';
import 'package:template_app/config/api_config.dart';
import 'package:template_app/model/cart_item_model.dart';
import 'package:template_app/model/product_model.dart';
import 'package:template_app/service/cart_service.dart';

class CartController extends GetxController {
  var numOfItem = 1.obs;
  // var totalQuantity = 0.obs;
  // var cartItem = <CartItemModel>[].obs;
  void removeItem() {
    if (numOfItem.value > 1) {
      numOfItem.value--;
    }
  }

  void addItem() {
    numOfItem.value++;
  }

  final RxList<CartItemModel> carts = <CartItemModel>[].obs;
  @override
  void onInit() {
    getCart();
    super.onInit();
  }

  void getCart() async {
    try {
      final cartService = Get.find<CartService>();
      final cartList = await cartService.getCart();
      carts.addAll(cartList);
      // final cartModels = cartList
      //     .map((product) => CartItemModel(
      //           id: product.id,
      //           title: product.title,
      //           quantity: product.quantity,
      //           price: product.price,
      //           imageUrl: product.imageUrl,
      //         ))
      //     .toList();
      // carts.assignAll(cartModels);
    } catch (e) {
      print('Error fetching cart items: $e');
    }
  }

  void addToCart(CartItemModel item) async {
    try {
      final cartService = Get.find<CartService>();
      final addcart = await cartService.addToCart(
        item.id,
        item.title,
        item.price,
        item.imageUrl,
        item.quantity,
      );
      final index = carts.indexWhere((addcart) => addcart.id == item.id);
      if (index >= 0) {
        carts[index].quantity += item.quantity;
      } else {
        carts.add(item);
      }
    } catch (e) {
      print('Error adding item to cart: $e');
    }
  }

  void removeFromCart(CartItemModel item) async {
    try {
      final cartService = Get.find<CartService>();
      final delcart = await cartService.removeFromCart(item.id);
      carts.remove(item);
    } catch (e) {
      print('Error removing item from cart: $e');
    }
  }

  // final List<CartItemModel> carts = [
  //   CartItemModel(
  //     id: 'c1',
  //     title: 'Tulip',
  //     price: 11.02,
  //     quantity: 2,
  //     imageUrl: "assets/images/Tulip.jpg",
  //   ),
  //   CartItemModel(
  //     id: 'c1',
  //     title: 'Tulip',
  //     price: 11.02,
  //     quantity: 2,
  //     imageUrl: "assets/images/Tulip.jpg",
  //   ),
  //   CartItemModel(
  //     id: 'c1',
  //     title: 'Tulip',
  //     price: 11.02,
  //     quantity: 2,
  //     imageUrl: "assets/images/Tulip.jpg",
  //   ),
  //   CartItemModel(
  //     id: 'c1',
  //     title: 'Tulip',
  //     price: 11.02,
  //     quantity: 2,
  //     imageUrl: "assets/images/Tulip.jpg",
  //   ),
  // ];

  // void addItemInCart(ProductModel product) {
  //   final index = cartItem.indexWhere((element) => element.id == product);
  //   if (index > 0) {
  //     cartItem[index] = CartItemModel(
  //         id: product.id,
  //         title: product.title,
  //         quantity: (numOfItem.value + cartItem[index].quantity),
  //         price: cartItem[index].price,
  //         imageUrl: product.imageUrl);
  //   }else{
  //     cartItem.add(CartItemModel(id: product.id,
  //         title: product.title,
  //         quantity: numOfItem.value,
  //         price: cartItem[index].price,
  //         imageUrl: product.imageUrl));
  //   }
  //   totalQuantity.value = totalQuantity.value + numOfItem.value;
  //   numOfItem.value = 1;
  // }

}
