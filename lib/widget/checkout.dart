import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template_app/config/app_config.dart';
import 'package:template_app/model/cart_model.dart';
import 'package:template_app/model/order_model.dart';
import 'package:template_app/widget/cart.dart';
import 'package:template_app/widget/common/my_app_bar.dart';
import 'package:template_app/widget/common/my_bottom_bar.dart';

import '../controller/cart_controller.dart';
import '../controller/order_controller.dart';
import '../service/user_service.dart';
import '../util/format_util.dart';

class Checkout extends GetView<CartController> {
  const Checkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();

    return Scaffold(
      appBar: MyAppBar(title: "dat hang".tr),
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _checkoutBody(context),
            _checkoutDetail(),
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomBar(index: 2),
    );
  }

  Widget _checkoutBody(BuildContext context) {
    final _userService = Get.put(UserService());
    final totalValue = double.parse(controller.total.value);
    final calculatedTotal = totalValue + 20000;
    final OrderController orderController = Get.find<OrderController>();
    final userId = _userService.currentUser?.userId ?? "";

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(
                  top: 15,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 208, 207, 207),
                      offset: Offset(0.0, 3.0),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Row(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRowWithIcon(
                              context,
                              _userService.currentUser?.fullName == ""
                                  ? "chua cap nhat".tr
                                  : _userService.currentUser?.fullName ??
                                      "chua cap nhat".tr,
                              Icons.person_rounded,
                              isShow: true),
                          const Divider(),
                          _buildRowWithIcon(
                              context,
                              _userService.currentUser?.phoneNumber == ""
                                  ? "chua cap nhat".tr
                                  : _userService.currentUser?.phoneNumber ??
                                      "chua cap nhat".tr,
                              Icons.phone,
                              iconColor: Colors.green,
                              isShow: false),
                          const Divider(),
                          _buildRowWithIcon(
                              context,
                              _userService.currentUser?.address == ""
                                  ? "chua cap nhat".tr
                                  : _userService.currentUser?.address ??
                                      "chua cap nhat".tr,
                              Icons.location_pin,
                              iconColor: Colors.red,
                              isShow: false),
                          const Divider(),
                          _buildRow(
                              "Tổng tiền hàng: ${FormatUtils.formatPrice(controller.total.value)} \VNĐ"),
                          const Divider(),
                          _buildRow("Phí vận chuyển: 20.000 \VNĐ"),
                          const Divider(),
                          _buildRow(
                              "Tổng thanh toán: ${FormatUtils.formatPrice(calculatedTotal.toString())} \VNĐ"),
                        ],
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: 200,
                            height: 52,
                            child: FloatingActionButton.extended(
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              backgroundColor: Colors.pink.shade100,
                              foregroundColor: Colors.white,

                              ///
                              onPressed: () {
                                String phoneNumber =
                                    _userService.currentUser?.phoneNumber ?? "";
                                String fullName =
                                    _userService.currentUser?.fullName ?? "";
                                String address =
                                    _userService.currentUser?.address ?? "";
                                if (phoneNumber.isEmpty ||
                                    fullName.isEmpty ||
                                    address.isEmpty) {
                                  // Hiển thị thông báo nếu trường tên người dùng chưa được điền
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      content: Text(
                                        'vui long cap nhat day du thong tin'.tr,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Get.toNamed("/profile/edit");
                                          },
                                          child: const Text(
                                            'Cập nhật',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 20),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  // Hiển thị hộp thoại xác nhận đặt hàng
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      content: const Text(
                                        'Xác nhận đặt hàng',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text(
                                            'Hủy',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 20),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // Tạo đơn hàng và lưu vào cơ sở dữ liệu
                                            final List<CartItem> cartItems =
                                                controller.carts.toList();
                                            orderController
                                                .submitOrder(cartItems);
                                          },
                                          child: const Text(
                                            'Đồng ý',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },

                              ///
                              label: Text(
                                'xac nhan'.tr.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRowWithIcon(BuildContext context, String text, IconData icon,
      {Color? iconColor, bool isShow = true}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor),
            SizedBox(width: 15),
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontFamily: AutofillHints.addressCity,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 80,
        ), // SizedBox sẽ chiếm hết phần dư màn hình
        if (isShow) _userInfo(context),
      ],
    );
  }

  Widget _userInfo(BuildContext context) {
    return Container(
      child: CircleAvatar(
        backgroundColor: Colors.pink[50],
        child: IconButton(
          onPressed: () => {
            Get.toNamed("/profile/edit"),
          },
          icon: const Icon(Icons.create),
        ),
      ),
    );
  }

  Widget _buildRow(String text) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: AutofillHints.addressCity,
          ),
        ),
      ],
    );
  }

  Widget _checkoutDetail() {
    final _userService = UserService();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.carts.length,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                final CartItem cartItem = controller.carts[i];
                return Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
                  child: CartItemCard(
                    productId: controller.carts[i].productId,
                    cardItem: controller.carts[i],
                    onDecreaseQuantity: (newQuantity) {
                      controller.updateCartItemQuantity(
                        _userService.currentUser?.userId ?? "",
                        controller.carts[i].productId,
                        newQuantity,
                      );
                    },
                    onIncreaseQuantity: (newQuantity) {
                      controller.updateCartItemQuantity(
                        _userService.currentUser?.userId ?? "",
                        controller.carts[i].productId,
                        newQuantity,
                      );
                    },
                    isContainerVisible: false,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
