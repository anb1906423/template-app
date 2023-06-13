import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template_app/util/input_util.dart';
import 'package:template_app/widget/common/my_bottom_bar.dart';

import '../service/user_service.dart';

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  // File _image;

  // Future<void> _pickImage() async {
  //   final picker = ImagePicker();
  //   final pickedImage = await picker.getImage(source: ImageSource.gallery);

  //   setState(() {
  //     if (pickedImage != null) {
  //       _image = File(pickedImage.path);
  //       // Gọi hàm xử lý upload ảnh tại đây
  //       _uploadImage(_image);
  //     }
  //   });
  // }

  // Future<void> _uploadImage(File image) async {
  //   // Xử lý upload ảnh tại đây
  //   // ...
  // }

  @override
  Widget build(BuildContext context) {
    final userService = Get.put(UserService());

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
                        InputUtil.buildInput("Ho va ten", "Ho va ten", value: userService.currentUser?.fullName ?? "", disabled: false),
                        InputUtil.buildInput("So dien thoai", "So dien thoai", value: userService.currentUser?.phoneNumber ?? "", disabled: false),
                        InputUtil.buildInput("Email", 'Email', value: userService.currentUser?.email ?? "", disabled: true),
                        InputUtil.buildInput("Dia chi", "Dia chi", value: userService.currentUser?.address ?? "", disabled: false),
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
                      borderRadius: BorderRadius.circular(10), // Độ cong của góc
                    ),
                    child: TextButton(
                      onPressed: () {},
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
