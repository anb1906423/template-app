import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template_app/controller/product_detail_controller.dart';
import 'package:template_app/widget/common/my_app_bar.dart';
import 'package:template_app/widget/common/my_bottom_bar.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:template_app/widget/product.dart';

import '../controller/cart_controller.dart';
import '../controller/favorite_controller.dart';
import '../service/user_service.dart';
import '../util/format_util.dart';

class ProductDetail extends GetView<ProductDetailController> {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userService = UserService();
    CartController cartController = Get.find<CartController>();
    final FavoriteController favoriteController =
        Get.find<FavoriteController>();
    bool isFavorite = favoriteController.isProductFavorite(
        _userService.currentUser?.userId ?? "", controller.product!.id);
    print(isFavorite);

    return Scaffold(
      appBar: MyAppBar(
        title: 'chi tiet san pham'.tr,
        // actions: [filter(), badge()],
      ),
      backgroundColor: Colors.pink.shade50,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 310,
              width: double.infinity,
              child: Image.network(
                controller.product!.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  Text(
                    controller.product!.title,
                    textAlign: TextAlign.left,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const Spacer(), // Thêm Spacer widget vào đây
                  Container(
                    child: Text(
                      "${FormatUtils.formatPrice(controller.product?.price.toString() ?? "")} VNĐ",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 92, 92, 92),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              isFavorite = favoriteController.isProductFavorite(
                  _userService.currentUser?.userId ?? "",
                  controller.product!.id);
              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                color: Colors.red,
                onPressed: () {
                  String userId = _userService.currentUser?.userId ?? "";
                  String productId = controller.product!.id;

                  if (isFavorite) {
                    favoriteController.removeFavorites(userId, productId);
                  } else {
                    favoriteController.addToFavorites(userId, productId);
                  }
                },
              );
            }),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              child: Html(
                data: controller.product!.description,
                style: {
                  "body": Style(
                    fontSize: FontSize(15),
                  ),
                },
                // customTextStyle: (node, baseStyle) {
                //   if (node is dom.Element) {
                //     switch (node.localName) {
                //       case "strong":
                //         return baseStyle.copyWith(fontWeight: FontWeight.bold);
                //       // Các phần tử HTML khác có thể được xử lý tương tự
                //     }
                //   }
                //   return baseStyle;
                // },
                // onLinkTap: (url) {
                //   // Xử lý khi người dùng nhấp vào liên kết
                // },
                // onImageTap: (src) {
                //   // Xử lý khi người dùng nhấp vào hình ảnh
                // },
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              )),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 0,
                  right: 0,
                  bottom: 10,
                  top: 40,
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 15, left: 50, right: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.pink.shade100,
                  ),
                  onPressed: () {
                    cartController.addToCart(
                      _userService.currentUser?.userId ?? "",
                      controller.product!.id,
                      controller.product!.price,
                      controller.product!.title,
                      controller.product!.imageUrl,
                      quantity: 1,
                    );
                  },
                  child: const Text(
                    "Thêm giỏ hàng",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomBar(index: 1),
    );
  }
}
