import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:template_app/controller/history_controller.dart';
import 'package:template_app/model/cart_model.dart';
import 'package:template_app/model/order_model.dart';
import 'package:template_app/service/user_service.dart';
import 'package:template_app/util/app_util.dart';
import 'package:template_app/widget/common/my_bottom_bar.dart';

import '../controller/order_controller.dart';
import '../service/user_service.dart';
import 'order_detail.dart';

class History extends GetView<OrderController> {
  History({Key? key}) : super(key: key);

  final UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    OrderController orderController = Get.find<OrderController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch Sử Đơn Hàng'),
        backgroundColor: Colors.pink.shade100,
      ),
      backgroundColor: Colors.pink.shade50,
      body: GetX<OrderController>(
        builder: (orderController) {
          print(orderController.orders.length);
          print(orderController.orders.isEmpty);
          return Obx(() {
            if (orderController.orders.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return _buildOrderItemCard(context);
            }
          });
        },
      ),
      bottomNavigationBar: const MyBottomBar(index: 0),
    );
  }

  Widget _buildOrderItemCard(BuildContext context) {
    // OrderController orderController = Get.find<OrderController>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Container(
            child: const Text(
              'DANH SÁCH ĐƠN HÀNG',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: controller.orders.length,
            itemBuilder: (context, index) {
              final order = controller.orders[index];
              final firstItem = order.items.first;
              final formatter = DateFormat('dd/MM/yyyy hh:mm:ss');
              double totalCost = double.parse(order.total) +
                  double.parse(order.deliveryCharges);

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    // Chuyển sang màn hình chi tiết đơn hàng
                    Get.to(() => OrderDetail(order: order));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            SizedBox(
                              width: 160,
                              child: Text(
                                "${order.id}",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black87,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textScaleFactor: 1,
                              ),
                            ),
                            Spacer(),
                            Text(
                              order.isPaid ? "Hoàn thành" : "Chưa hoàn thành",
                              style: TextStyle(
                                fontSize: 15,
                                color: order.isPaid ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.0),
                        Row(
                          children: <Widget>[
                            Text(
                              "${formatter.format(order.createdAt)}",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[600],
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${NumberFormat.decimalPattern().format(totalCost)} \VNĐ",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}