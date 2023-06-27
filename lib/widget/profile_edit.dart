import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:template_app/controller/user_controller.dart';
import 'package:template_app/util/input_util.dart';
import 'package:template_app/widget/common/my_bottom_bar.dart';

import '../model/user_model.dart';
import '../service/user_service.dart';

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final userService = Get.put(UserService());
    UserController _userController = Get.find<UserController>();
    TextEditingController fullNameController =
        TextEditingController(text: userService.currentUser?.fullName ?? "");
    TextEditingController phoneNumberController =
        TextEditingController(text: userService.currentUser?.phoneNumber ?? "");
    TextEditingController addressController =
        TextEditingController(text: userService.currentUser?.address ?? "");
    TextEditingController emailController =
        TextEditingController(text: userService.currentUser?.email ?? "");

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('cap nhat thong tin ca nhan'.tr),
        backgroundColor: Colors.pink[100],
      ),
      backgroundColor: Colors.pink.shade50,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 303,
            padding: EdgeInsets.only(top: 24, bottom: 16),
            child: Center(
              child: Column(children: [
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
                    padding: EdgeInsets.only(top: 24, bottom: 16),
                    child: Column(
                      children: [
                        InputUtil.buildInput("Ho va ten", "Ho va ten",
                            // value: userService.currentUser?.fullName ?? "",
                            disabled: false,
                            controller: fullNameController),
                        InputUtil.buildInput("So dien thoai", "So dien thoai",
                            // value: userService.currentUser?.phoneNumber ?? "",
                            disabled: false,
                            controller: phoneNumberController),
                        InputUtil.buildInput("Email", 'Email',
                            // value: userService.currentUser?.email ?? "",
                            disabled: true,
                            controller: emailController),
                        InputUtil.buildInput("Dia chi", "Dia chi",
                            // value: userService.currentUser?.address ?? "",
                            disabled: false,
                            controller: addressController),
                      ],
                    )),
                Container(
                  width: double.infinity,
                  height: 8,
                ),
                Container(
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.pink.shade100, // Màu nền
                      borderRadius:
                          BorderRadius.circular(10), // Độ cong của góc
                    ),
                    child: TextButton(
                      onPressed: () {
                        UserModel updatedUser = UserModel(
                          fullName: fullNameController.text,
                          phoneNumber: phoneNumberController.text,
                          email: userService.currentUser?.email ?? "",
                          address: addressController.text,
                          userId: userService.currentUser?.userId ?? "",
                          token: GetStorage().read('token') ??
                              "", // Lấy giá trị token từ GetStorage
                        );
                        _userController.updateUserProfile(updatedUser);
                      },
                      child: Text(
                        "luu".tr,
                        style: TextStyle(color: Colors.white, fontSize: 19),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const MyBottomBar(index: 3),
    );
  }
}
