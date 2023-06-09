import 'package:get/get.dart';
import 'package:template_app/model/cart_item_model.dart';

class CartController extends GetxController {
  var quantity = 1.obs;
  void removeItem(){
    if(quantity.value > 1){
      quantity.value -- ;
    }
  }
  void addItem(){
    quantity.value ++ ;
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
