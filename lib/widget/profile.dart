import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template_app/config/app_config.dart';
import 'package:template_app/widget/common/my_bottom_bar.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('trang ca nhan'.tr),
        backgroundColor: Colors.pink.shade100,
      ),
      backgroundColor: Colors.pink.shade50,
      body: Container(
        padding: EdgeInsets.only(top: 24, bottom: 16),
        // color: AppConfig.buttonColor,
        child: Center(
          child: Column(
            children: [
              Container(
                width: 126,
                height: 126,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                    image: AssetImage('assets/images/Lan.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 28),
                  child: const Text(
                    "Lê Văn Sơn",
                    style: TextStyle(
                      fontSize: 21,
                    ),
                  ),
                ),
              ),
              Container(
                width: 350,
                padding: EdgeInsets.all(13.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(
                        "thong tin ca nhan".tr,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => Get.toNamed("/profile/edit"),
                            child: Text(
                              'chinh sua'.tr,
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.none,
                                fontSize: 21,
                              ),
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 8),
                    height: 1.0,
                    color: Colors.black38,
                  ),
                  Column(
                    children: [
                      infoItemMethod("ho va ten", "Lê Văn Sơn"),
                      infoItemMethod("so dien thoai", "0819222273"),
                      infoItemMethod("email", "email@gmail.com"),
                      infoItemMethod("dia chi", "Cái Răng, Cần Thơ"),
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MyBottomBar(index: 3),
    );
  }

  Row infoItemMethod(String field, String value) {
    return Row(children: [
      Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            field.tr,
            style: TextStyle(fontSize: 18),
          )),
      Text(
        value.tr,
        style: TextStyle(fontSize: 18),
      ),
    ]);
  }
}
