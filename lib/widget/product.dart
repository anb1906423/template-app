import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template_app/controller/product_controller.dart';
import 'package:template_app/model/product_model.dart';
import 'package:template_app/widget/common/my_bottom_bar.dart';

import '../controller/cart_controller.dart';
import '../controller/favorite_controller.dart';
import '../service/product_service.dart';
import '../service/user_service.dart';
import '../util/format_util.dart';

int totalQuantity = 0;

class Product extends GetView<ProductController> {
  Product({Key? key}) : super(key: key);
  final _userService = UserService();
  final FavoriteController favoriteController = Get.find();

  @override
  Widget build(context) {
    favoriteController
        .getFavoritesByUserId(_userService.currentUser?.userId ?? "");

    Get.put(ProductService());

return Scaffold(
  appBar: AppBar(
    actions: [filter(), badge()],
    title: Text('san pham'.tr),
    backgroundColor: Colors.pink.shade100,
  ),
  backgroundColor: Colors.pink.shade50,
  body: Column(
    children: [
      Expanded(
        child: Obx(() {
          // Hiển thị danh sách sản phẩm cho trang hiện tại
          final startIndex =
              (controller.currentPage.value - 1) * controller.itemsPerPage;
          final endIndex = startIndex + controller.itemsPerPage;
          final displayedProducts = controller.products
              .sublist(startIndex, endIndex.clamp(0, controller.products.length));
          if (displayedProducts.isEmpty) {
            return Center(
              child: Text(
                "danh sach san pham dang trong!".tr,
                style: TextStyle(fontSize: 18),
              ),
            );
          } else {
            return GridView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: displayedProducts.length,
              itemBuilder: (ctx, i) => _productGridTile(
                context: context,
                product: displayedProducts[i],
              ),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            );
          }
        }),
      ),
      Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => controller.goToPage(
                    controller.currentPage.value - 1),
              ),
              Text('Trang ${controller.currentPage.value} / ${controller.totalPages.value}'),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () => controller.goToPage(
                    controller.currentPage.value + 1),
              ),
            ],
          )),
    ],
  ),
  bottomNavigationBar: const MyBottomBar(index: 1),
);


  }

  Widget _productGridTile({required context, required ProductModel product}) {
    final userService = UserService();
    CartController cartController = Get.find<CartController>();

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: GestureDetector(
            onTap: () => Get.toNamed("/product/detail/${product.id}"),
            child: Image.network(
              product.imageUrl,
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
                product.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Align(
                child: Container(
                  child: Text(
                    '${FormatUtils.formatPrice(product.price)} VNĐ',
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
                product.id,
                product.price,
                product.title,
                product.imageUrl,
                quantity: 1,
              );
            },
            color: Colors.pink.shade100,
          ),
        ),
      ),
    );
  }

  Widget filter() {
    return PopupMenuButton(
      onSelected: (value) {
        if (value == "FilterOptions.favorite") {
          Get.toNamed('/favorite');
        }
      },
      icon: const Icon(
        Icons.more_vert,
      ),
      itemBuilder: (ctx) => [
        const PopupMenuItem(
          value: "FilterOptions.favorite",
          child: Text('Hiển thị sản phẩm yêu thích'),
        ),
      ],
    );
  }

  Widget badge() {
    CartController cartController = Get.find<CartController>();

    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            Get.toNamed("/cart");
          },
        ),
        Positioned(
          right: 8,
          top: 8,
          child: Container(
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.red,
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Obx(
                () => Text(
                  cartController.carts.length.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
              )),
        )
      ],
    );
  }
}
