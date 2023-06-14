import 'package:get/get.dart';
import 'package:template_app/config/api_config.dart';
import 'package:template_app/model/cart_item_model.dart';
import 'package:template_app/model/product_model.dart';

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
  
  final List<CartItemModel> carts = [
    CartItemModel(
      id: 'c1',
      title: 'Tulip',
      price: 11.02,
      quantity: 2,
      imageUrl: "assets/images/Tulip.jpg",
    ),
    CartItemModel(
      id: 'c1',
      title: 'Tulip',
      price: 11.02,
      quantity: 2,
      imageUrl: "assets/images/Tulip.jpg",
    ),
    CartItemModel(
      id: 'c1',
      title: 'Tulip',
      price: 11.02,
      quantity: 2,
      imageUrl: "assets/images/Tulip.jpg",
    ),
    CartItemModel(
      id: 'c1',
      title: 'Tulip',
      price: 11.02,
      quantity: 2,
      imageUrl: "assets/images/Tulip.jpg",
    ),
  ];

}
