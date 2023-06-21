import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template_app/service/user_service.dart';
import 'package:template_app/util/app_util.dart';
import 'package:template_app/util/dialog_util.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userService = UserService();

    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.pink.shade100,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(
                      top: 50,
                      bottom: 20,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://cdn5.vectorstock.com/i/1000x1000/34/29/flower-shop-logo-template-with-rose-element-vector-18503429.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text(
                    'FlowerShop',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.update, size: 24),
            title: Transform.translate(
              offset: const Offset(-16, 0),
              child: Text('lich su don hang'.tr,
                  style: const TextStyle(fontSize: 16)),
            ),
            onTap: () => Get.toNamed("/history"),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language, size: 24),
            title: Transform.translate(
              offset: const Offset(-16, 0),
              child: Text(
                "ngon ngu".tr,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            trailing: Wrap(
              children: [
                Text(AppUtil().getLanguageName()),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                const Icon(Icons.arrow_forward_ios,
                    size: 16, color: Colors.black),
              ],
            ),
            onTap: () => Get.toNamed("/setting/language"),
          ),
          const Divider(),
          if (userService.isLoggedIn())
            ListTile(
              leading: const Icon(Icons.logout, size: 24),
              title: Transform.translate(
                offset: const Offset(-16, 0),
                child:
                    Text('dang xuat'.tr, style: const TextStyle(fontSize: 16)),
              ),
              onTap: () async {
                bool? result =
                    await showConfirmDialog(context, "Bạn chắc chắn đăng xuất");
                if (result == true) {
                  Get.toNamed("/login");
                  userService.logout();
                }
              },
            )
          else
            ListTile(
              leading: const Icon(Icons.login_outlined, size: 24),
              title: Transform.translate(
                offset: const Offset(-16, 0),
                child:
                    Text('dang nhap'.tr, style: const TextStyle(fontSize: 16)),
              ),
              onTap: () => Get.toNamed("/login"),
            ),
          const Divider(),
        ],
      ),
    );
  }
}
