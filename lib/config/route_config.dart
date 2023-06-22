import 'package:get/get.dart';
import 'package:template_app/binding/all_binding.dart';
import 'package:template_app/widget/cart.dart';
import 'package:template_app/widget/checkout.dart';
import 'package:template_app/widget/history.dart';
import 'package:template_app/widget/home.dart';
import 'package:template_app/widget/product.dart';
import 'package:template_app/widget/product_detail.dart';
import 'package:template_app/widget/profile.dart';
import 'package:template_app/widget/profile_edit.dart';
import 'package:template_app/widget/setting_language.dart';
import '../widget/favorite.dart';
import '../widget/login.dart';
import '../widget/register.dart';

class RouteConfig {
  static get routes {
    return [
      GetPage(name: "/home", page: () => Home(), binding: AllBinding()),
      GetPage(name: "/product", page: () =>   Product(), binding: AllBinding()),
      GetPage(name: "/product/detail/:id", page: () =>  ProductDetail(), binding: AllBinding()),
      GetPage(name: "/cart", page: () =>  Cart(), binding: AllBinding()),
      GetPage(name: "/checkout", page: () => const Checkout(), binding: AllBinding()),
      GetPage(name: "/profile", page: () => const Profile(), binding: AllBinding()),
      GetPage(name: "/profile/edit", page: () => const ProfileEdit(), binding: AllBinding()),
      GetPage(name: "/history", page: () =>  History(), binding: AllBinding()),
      GetPage(name: "/setting/language", page: () => const SettingLanguage(), binding: AllBinding()),
      GetPage(name: "/register", page: () => const Register(), binding: AllBinding()),
      GetPage(name: "/login", page: () => Login(), binding: AllBinding()),
      GetPage(name: "/favorite", page: () => Favorite(), binding: AllBinding()),
    ];
  }
}
