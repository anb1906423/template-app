import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template_app/controller/cart_controller.dart';
import 'package:template_app/model/favorite_model.dart';
import 'package:template_app/widget/product.dart';

import '../controller/favorite_controller.dart';
import '../model/product_model.dart';
import '../service/user_service.dart';
import '../util/format_util.dart';

class Favorite extends GetView<FavoriteController> {
  Favorite({Key? key}) : super(key: key);
  final _userService = UserService();

  final FavoriteController favoriteController = Get.find();

  @override
  Widget build(context) {
    favoriteController
        .getFavoritesByUserId(_userService.currentUser?.userId ?? "");

    return Scaffold(
      appBar: AppBar(
        title: Text("san pham yeu thich".tr),
        backgroundColor: Colors.pink.shade100,
      ),
      backgroundColor: Colors.pink.shade50,
      body: Obx(
        () {
          if (controller.favorites.isEmpty) {
            return Center(
              child: Text(
                "danh sach san pham dang trong!".tr,
                style: TextStyle(fontSize: 18),
              ),
            );
          } else {
            return GridView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: controller.favorites.length,
              itemBuilder: (ctx, i) => favoriteGridTile(
                context: context,
                favorite: controller.favorites[i],
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            );
          }
        },
      ),
    );
  }

  Widget favoriteGridTile({required context, required FavoriteModel favorite}) {
    final userService = UserService();
    CartController cartController = Get.find<CartController>();

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: GestureDetector(
            onTap: () => Get.toNamed("/product/detail/${favorite.productId}"),
            child: Image.network(
              favorite.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.white,
          title: Column(
            children: <Widget>[
              const SizedBox(height: 5),
              Text(
                favorite.name,
                //textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Align(
                //alignment: Alignment.centerRight,
                child: Container(
                  child: Text(
                    '${FormatUtils.formatPrice(favorite.price)} VNĐ',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 92, 92, 92),
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              cartController.addToCart(
                userService.currentUser?.userId ?? "",
                favorite.productId,
                favorite.price,
                favorite.name,
                favorite.image,
                quantity: 1,
              );
            },
            color: Colors.pink.shade100,
          ),
        ),
      ),
    );
  }
}
