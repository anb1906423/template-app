import 'package:get/get.dart';
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
