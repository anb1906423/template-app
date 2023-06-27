import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template_app/controller/cart_controller.dart';
import 'package:template_app/widget/common/my_bottom_bar.dart';

import '../model/cart_model.dart';
import '../service/user_service.dart';
import '../util/format_util.dart';

class Cart extends GetView<CartController> {
  Cart({Key? key}) : super(key: key);
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     // Xử lý khi người dùng nhấn nút back arrow
        //     Get.toNamed("/product"); // Chuyển về trang có route "/home"
        //   },
        // ),
        title: Text('gio hang'.tr),
        backgroundColor: Colors.pink.shade100,
      ),
      backgroundColor: Colors.pink.shade50,
      body: Column(
        children: <Widget>[
          _buildCartSummary(context),
          Expanded(
            child: _buildCartDetails(context),
          ),
          _buildPayment(context),
          SizedBox(
            height: 20,
          ),
        ],
      ),
      bottomNavigationBar: const MyBottomBar(index: 2),
    );
  }

  Widget _buildCartDetails(BuildContext context) {
    final _userService = UserService();

    if (controller.carts.isEmpty) {
      return Center(
        child: Text(
          'Chưa có sản phẩm nào trong giỏ hàng',
          style: TextStyle(fontSize: 16),
        ),
      );
    } else {
      return Obx(() => ListView.builder(
            itemCount: controller.carts.length,
            itemBuilder: (context, i) {
              final CartItem cartItem = controller.carts[i];

              if (cartItem.quantity > 0) {
                return Dismissible(
                  key: ValueKey(cartItem.productId),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) async {
                    final bool shouldDelete = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Xóa sản phẩm?"),
                          content: Text(
                              "Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng?"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text("Hủy bỏ"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text("Xóa"),
                            ),
                          ],
                        );
                      },
                    );
                    return shouldDelete;
                  },
                  onDismissed: (direction) {
                    controller.removeCartItem(
                      cartItem.productId,
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  child: CartItemCard(
                    productId: cartItem.productId,
                    cardItem: cartItem,
                    onDecreaseQuantity: (newQuantity) {
                      controller.updateCartItemQuantity(
                        _userService.currentUser?.userId ?? "",
                        cartItem.productId,
                        newQuantity,
                      );
                    },
                    onIncreaseQuantity: (newQuantity) {
                      controller.updateCartItemQuantity(
                        _userService.currentUser?.userId ?? "",
                        cartItem.productId,
                        newQuantity,
                      );
                    },
                    isContainerVisible: true,
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ));
    }
  }

  Widget _buildPayment(BuildContext context) {
    return Obx(() {
      if (controller.carts.isEmpty) {
        return SizedBox.shrink(); // Ẩn nút "Đặt hàng" nếu giỏ hàng rỗng
      } else {
        return Container(
          margin: EdgeInsets.only(top: 20),
          child: TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 15, left: 70, right: 70),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: Colors.pink.shade100,
            ),
            onPressed: () => Get.toNamed("/checkout"),
            child: Text(
              "dat hang".tr,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        );
      }
    });
  }

  Widget _buildCartSummary(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'tong'.tr,
              style: TextStyle(fontSize: 20),
            ),
            const Spacer(),
            Obx(
              () => Chip(
                label: Text(
                  // "${controller.total.value} VNĐ",
                  '${FormatUtils.formatPrice(controller.total.value)} VNĐ',
                  style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.titleLarge?.color,
                    fontSize: 16,
                  ),
                ),
                backgroundColor: Colors.pink[100],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget CartItemCard({
  required String productId,
  required CartItem cardItem,
  required Function(int) onDecreaseQuantity,
  required Function(int) onIncreaseQuantity,
  required bool isContainerVisible,
  // required Function() onDelete,
}) {
  return Container(
    margin: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.white),
      boxShadow: const [
        BoxShadow(
          blurRadius: 8,
          offset: Offset(0, 4),
          color: Colors.grey,
        ),
      ],
    ),
    child: Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: AspectRatio(
              aspectRatio: 0.9,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    cardItem.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cardItem.title,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 65, 54, 54),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              FormatUtils.formatPrice(cardItem.price),
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.pinkAccent,
                              ),
                            ),
                            const Text(
                              " \VNĐ",
                              style: TextStyle(
                                color: Colors.pinkAccent,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: isContainerVisible,
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 2,
                              bottom: 2,
                              left: 10,
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.pink[50],
                            ),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    // Gọi hàm onDecreaseQuantity và truyền giá trị số lượng giảm đi 1
                                    onDecreaseQuantity(cardItem.quantity - 1);
                                  },
                                  child: const Icon(
                                    Icons.remove,
                                    color: Color.fromARGB(255, 211, 36, 91),
                                    size: 20,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 3,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 3,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Obx(() => Text(
                                        cardItem.quantity
                                            .toString()
                                            .padLeft(2, "0"),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      )),
                                ),
                                InkWell(
                                  onTap: () {
                                    // Gọi hàm onIncreaseQuantity và truyền giá trị số lượng tăng lên 1
                                    onIncreaseQuantity(cardItem.quantity + 1);
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    color: Color.fromARGB(255, 211, 36, 91),
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: !isContainerVisible,
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 2,
                              bottom: 2,
                              left: 10,
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.pink[50],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 3,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 3,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Obx(() => Text(
                                        "x${cardItem.quantity.toString()}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
