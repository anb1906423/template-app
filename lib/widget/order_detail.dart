import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:template_app/controller/order_controller.dart';

import '../model/order_model.dart';
import '../service/user_service.dart';
import 'common/my_bottom_bar.dart';

class OrderDetail extends GetView<OrderController> {
  final Order order;
  OrderDetail({required this.order, Key? key}) : super(key: key);

  final UserService userService = UserService();
  @override
  Widget build(BuildContext context) {
    OrderController orderController = Get.find<OrderController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('chi tiet don hang'.tr),
        backgroundColor: Colors.pink[100],
      ),
      body: GetBuilder<OrderController>(
        builder: (orderController) {
          print(orderController.orders.length);
          if (orderController.orders.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return _buildOrderDetailCard(context, order);
          }
        },
      ),
      bottomNavigationBar: const MyBottomBar(index: 0),
    );
  }

  Widget _buildOrderDetailCard(BuildContext context, Order order) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 16),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoItem(
                    '#${order.id}',
                    DateFormat('dd/MM/yyyy hh:mm:ss').format(order.createdAt),
                    titleFontWeight: FontWeight.bold,
                    valueFontWeight: FontWeight.normal,
                  ),
                  _infoItem(
                    "Địa chỉ",
                    '${order.address}',
                    titleFontWeight: FontWeight.normal,
                    valueFontWeight: FontWeight.bold,
                  ),
                  _infoItem(
                    "Khách hàng",
                    '${order.customerName}',
                    titleFontWeight: FontWeight.normal,
                    valueFontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            _blackLineWidget(),
            ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 6),
              physics: ClampingScrollPhysics(),
              itemCount: order.items.length + 4,
              separatorBuilder: (context, index) => SizedBox(height: 0),
              itemBuilder: (context, index) {
                if (index < order.items.length) {
                  final item = order.items[index];
                  double price = double.parse(item.price);

                  return _lineItemWidget(
                    item.productName,
                    price,
                    showQuantity: true,
                    quantity: item.quantity,
                  );
                } else if (index == order.items.length) {
                  // Hiển thị tổng tiền hàng
                  return _blackLineWidget();
                } else if (index == order.items.length + 1) {
                  // Hiển thị phí vận chuyển
                  return _lineItemWidget(
                    "Tổng tiền hàng",
                    double.parse(order.total),
                    showQuantity: false,
                  );
                } else if (index == order.items.length + 2) {
                  return _lineItemWidget(
                    "Phí vận chuyển",
                    double.parse(order.deliveryCharges),
                    showQuantity: false,
                  );
                } else {
                  // Hiển thị tổng chi phí (tổng tiền hàng + phí vận chuyển)
                  double totalCost = double.parse(order.total) +
                      double.parse(order.deliveryCharges);
                  return _lineItemWidget(
                    "Tổng chi phí",
                    totalCost,
                    showQuantity: false,
                    showIsPaid: true,
                    isPaid: order.isPaid,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoItem(String title, String value,
      {FontWeight titleFontWeight = FontWeight.normal,
      FontWeight valueFontWeight = FontWeight.bold}) {
    return Container(
      padding: EdgeInsets.only(bottom: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: titleFontWeight),
          ),
          Container(
            padding: EdgeInsets.only(top: 2),
            child: Text(
              value,
              style: TextStyle(fontWeight: valueFontWeight),
            ),
          ),
        ],
      ),
    );
  }

  Widget _blackLineWidget() {
    return Container(
      padding: EdgeInsets.only(top: 8),
      height: 1.0,
      color: Colors.black38,
    );
  }

  Widget _lineItemWidget(
    String title,
    double price, {
    bool showQuantity = true,
    int quantity = 1,
    bool? isPaid,
    bool showIsPaid = false,
  }) {
    String paidStatus = isPaid == true ? "Đã thanh toán" : "Chưa thanh toán";

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: showQuantity ? Text('x$quantity') : null,
      trailing: Text(
        '${NumberFormat.decimalPattern().format(price)} VNĐ ${showIsPaid ? "\n$paidStatus" : ""}',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.right,
      ),
    );
  }
}
