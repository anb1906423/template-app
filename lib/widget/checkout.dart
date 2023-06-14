import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template_app/config/app_config.dart';
import 'package:template_app/controller/checkout_controller.dart';
import 'package:template_app/model/cart_item_model.dart';
import 'package:template_app/widget/common/my_app_bar.dart';
import 'package:template_app/widget/common/my_bottom_bar.dart';

class Checkout extends GetView<CheckoutController> {
  const Checkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
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
                          _buildRowWithIcon(context, "Lý Thị Hồng Cẫm Nhi",
                              Icons.person_rounded,
                              isShow: true),
                          const Divider(),
                          _buildRowWithIcon(context, "0193758947", Icons.phone,
                              iconColor: Colors.green, isShow: false),
                          const Divider(),
                          _buildRowWithIcon(
                              context, "Ninh Kiều, Cần Thơ", Icons.location_pin,
                              iconColor: Colors.red, isShow: false),
                          const Divider(),
                          _buildRow("Tổng tiền hàng: 30.01 \$"),
                          const Divider(),
                          _buildRow("Phí vận chuyển: 1.05 \$"),
                          const Divider(),
                          _buildRow("Tổng thanh toán: 31.06 \$"),
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
                              onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  content: const Text(
                                    'Xác nhận đặt hàng',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text(
                                        'Hủy',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 20),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => {},
                                      child: const Text(
                                        'Đồng ý',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              ///
                              label: Text(
                                'XÁC NHẬN',
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.carts.length,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 12),
                child: _CheckOutItem(
                  flower: controller.carts[i],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _CheckOutItem({required CartItem flower}) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(color: Colors.white),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              offset: Offset(0, 3),
              color: AppConfig.buttonColor,
            ),
          ]),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(10.0), // Border radius cho hình ảnh
              child: Image.asset(
                flower.imageUrl,
                width: 70,
                height: 70,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          flower.title,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 65, 54, 54)),
                        ),
                        const Spacer(),
                        const Text(
                          "x",
                        ),
                        Text(
                          (flower.quantity).toStringAsFixed(0),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Text(
                            (flower.price),
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.pinkAccent,
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
}
