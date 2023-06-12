import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template_app/model/product_model.dart';

class CartCounterController extends GetxController{
  var numOfItems  = 0.obs;
  var CartList = <ProductModel>[].obs;
  void AddCartToList(ProductModel product){
      if(!CartList.contains(product)){
        CartList.add(product);
      numOfItems ++;
      }
      else{
        Get.snackbar(
          "Already there", 
          "you already liked this item!",
          backgroundColor: Colors.pink[50],
          snackPosition: SnackPosition.BOTTOM,
          borderColor: Colors.pink,
          colorText: Colors.black,
          borderRadius: 10,
          borderWidth: 2,
          barBlur: 0,
          );
      }
      

  }
}