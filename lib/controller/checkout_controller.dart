import 'package:get/get.dart';
import 'package:template_app/model/cart_item_model.dart';

class CheckoutController extends GetxController {
  final List<CartItem> carts = [
    CartItem(
      id: 'c1',
      title: 'Tulip',
      price: '11.02',
      quantity: 2,
      imageUrl: "assets/images/Tulip.jpg",
    ),
    CartItem(
      id: 'c1',
      title: 'Tulip',
      price: '11.02',
      quantity: 2,
      imageUrl: "assets/images/Tulip.jpg",
    ),
    CartItem(
      id: 'c1',
      title: 'Tulip',
      price: '11.02',
      quantity: 2,
      imageUrl: "assets/images/Tulip.jpg",
    ),
  ];
}