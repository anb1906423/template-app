import 'package:flutter/material.dart';
import 'package:template_app/config/app_config.dart';
import 'package:template_app/widget/common/app_drawer.dart';
import 'package:template_app/widget/common/my_app_bar.dart';
import 'package:template_app/widget/common/my_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:template_app/controller/product_controller.dart';
import 'package:dartz/dartz.dart' as dartz;
import '../controller/Order_controller.dart';
import '../controller/cart_controller.dart';
import '../service/product_service.dart';
import '../service/user_service.dart';
import '../util/format_util.dart';
import '../controller/favorite_controller.dart';

class Home extends GetView<ProductController> {
  Home({Key? key}) : super(key: key);
  final _userService = UserService();
  CartController cartController = Get.find<CartController>();
  final FavoriteController favoriteController = Get.find();

  @override
  Widget build(BuildContext context) {
    Get.put(ProductService());
    favoriteController
        .getFavoritesByUserId(_userService.currentUser?.userId ?? "");
        
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: MyAppBar(title: "trang chu".tr),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _header(context),
            _textLine(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _labelLine(text: "Tất cả sản phẩm"),
              ],
            ),
            _listAll(context: context),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _labelLine(text: "Loại hoa phổ biến"),
              ],
            ),
            Container(
              margin: EdgeInsets.only(right: 15),
              child: _listPopular(context: context),
            )
          ],
        ),
      ),
      drawer: AppDrawer(),
      bottomNavigationBar: const MyBottomBar(),
    );
  }

  Widget _header(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: size.height * 0.2,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 36 + 20,
            ),
            height: size.height * 0.17,
            decoration: BoxDecoration(
              image: const DecorationImage(
                  image: NetworkImage(
                      'https://wall.vn/wp-content/uploads/2019/11/hinh-nen-hoa-hong-dep-40.jpg'),
                  repeat: ImageRepeat.repeat),
              color: Colors.pink.shade100,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: <Widget>[
                Text(
                  'FlowerShop',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.symmetric(horizontal: 25),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 50,
                    color: AppConfig.kPrimaryColor.withOpacity(0.23),
                  )
                ],
              ),
              // Search
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        controller.searchProduct(dartz.Some(value));
                      },
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: Colors.pink.shade100.withOpacity(0.9),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    color: Colors.pink.shade100,
                    iconSize: 35,
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textLine() {
    return SizedBox(
      height: 24,
      child: Stack(
        children: <Widget>[
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 140),
            child: Text(
              "FlowerShop xin chào!!",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 195, 157, 157),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(right: 20 / 4),
              height: 7,
              color: AppConfig.kPrimaryColor.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _labelLine({required String text}) {
    return Container(
      height: 24,
      child: Stack(
        children: <Widget>[
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Lato',
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.only(left: 15),
              height: 7,
              color: AppConfig.kPrimaryColor.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listAll({required context}) {
    final ProductController productController = Get.put(ProductController());

    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.only(left: 15),
          child: Row(
            children: <Widget>[
              Obx(
                () {
                  final productList = controller.filteredProducts.isEmpty
                      ? controller.products
                      : controller.filteredProducts;
                  if (productList.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            "danh sach san pham dang trong!".tr,
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    );
                  } else
                    return Row(
                      children: [
                        for (var product in productList)
                          _itemAll(
                            context: context,
                            imageUrl: product.imageUrl,
                            id: product.id,
                            title: product.title,
                            price: product.price,
                            press: () {
                              // Xử lý khi nhấn vào sản phẩm
                              Get.toNamed("/product/detail/${product.id}");
                            },
                          ),
                      ],
                    );
                },
              )
            ],
          ),
        ));
  }

  Widget _itemAll(
      {required context,
      required imageUrl,
      required id,
      required title,
      required price,
      required press}) {
    Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(right: 15),
        width: size.width * 0.42 - 40,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: size.width * 0.42 - 40,
                height: size.width * 0.42 - 40, // Đảm bảo ảnh có tỷ lệ vuông
              ),
            ),
            GestureDetector(
              onTap: press,
              child: Container(
                padding:
                    EdgeInsets.only(top: 15, bottom: 15, left: 8, right: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4.0),
                    bottomRight: Radius.circular(4.0),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(10, 10),
                      blurRadius: 50,
                      spreadRadius: 25,
                      color: AppConfig.kPrimaryColor.withOpacity(0.23),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.button,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Text(
                          FormatUtils.formatPrice(price),
                          style: Theme.of(context)
                              .textTheme
                              .button
                              ?.copyWith(color: Colors.pink.shade100),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listPopular({required context}) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          _itemPopular(
            context: context,
            image: "assets/images/hoahong.jpg",
            press: () {
              Get.toNamed("/product");
            },
          ),
          _itemPopular(
            context: context,
            image: "assets/images/cuchoami.jpg",
            press: () {
              Get.toNamed("/product");
            },
          ),
          _itemPopular(
            context: context,
            image: "assets/images/huongduong.jpg",
            press: () {
              Get.toNamed("/product");
            },
          ),
          _itemPopular(
            context: context,
            image: "assets/images/hoaanhtuc.jpg",
            press: () {
              Get.toNamed("/product");
            },
          ),
          _itemPopular(
            context: context,
            image: "assets/images/camtucau.jpg",
            press: () {
              Get.toNamed("/product");
            },
          ),
        ],
      ),
    );
  }

  Widget _itemPopular({required context, required image, required press}) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(
          left: 15,
          right: 0,
          top: 15,
          bottom: 15,
        ),
        width: size.width * 0.8,
        height: 185,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(
          //   width: 10,
          //   color: Colors.pink.shade50,
          // ),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(image),
          ),
        ),
      ),
    );
  }
}
