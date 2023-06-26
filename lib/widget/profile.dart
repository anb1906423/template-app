import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template_app/config/app_config.dart';
import 'package:template_app/widget/common/my_app_bar.dart';
import 'package:template_app/widget/common/my_bottom_bar.dart';

import '../controller/user_controller.dart';
import '../service/user_service.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userService = Get.put(UserService());
    final user = _userService.getCurrentUser();
    final UserController userController = Get.put(UserController());

    return Scaffold(
      appBar: MyAppBar(
        title:'trang ca nhan'.tr
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
                    image: AssetImage('assets/images/user.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 28),
                  child: Text(
                    _userService.isLoggedIn()
                        ? _userService.currentUser?.fullName ?? "Ho va ten".tr
                        : "Bạn chưa đăng nhập",
                    style: TextStyle(
                      fontSize: 21,
                    ),
                  ),
                ),
              ),
              Builder(
                builder: (BuildContext context) {
                  if (_userService.isLoggedIn()) {
                    return Container(
                      width: 350,
                      padding: EdgeInsets.all(13.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "thong tin ca nhan".tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21,
                                  ),
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
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 8),
                            height: 1.0,
                            color: Colors.black38,
                          ),
                          Column(
                            children: [
                              infoItemMethod(
                                "ho va ten",
                                _userService.currentUser?.fullName == ""
                                    ? "chua cap nhat".tr
                                    : _userService.currentUser?.fullName ??
                                        "chua cap nhat".tr,
                              ),
                              infoItemMethod(
                                "so dien thoai",
                                _userService.currentUser?.phoneNumber == ""
                                    ? "chua cap nhat".tr
                                    : _userService.currentUser?.phoneNumber ??
                                        "chua cap nhat".tr,
                              ),
                              infoItemMethod(
                                "email",
                                _userService.currentUser?.email ?? "",
                              ),
                              infoItemMethod(
                                "dia chi",
                                _userService.currentUser?.address == ""
                                    ? "chua cap nhat".tr
                                    : _userService.currentUser?.address ??
                                        "chua cap nhat".tr,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ElevatedButton(
                      onPressed: () => Get.toNamed("/login"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.pink.shade100), // Set background color
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white), // Set text color
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15), // Set padding
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8), // Set border radius
                          ),
                        ),
                      ),
                      child: Text(
                        'dang nhap'.tr,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }
                },
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
