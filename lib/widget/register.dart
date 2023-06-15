import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template_app/controller/register_controller.dart';
import 'package:template_app/widget/login.dart';

import '../controller/user_controller.dart';

final UserController _userController = Get.put(UserController());
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class Register extends GetView<RegisterController> {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: BodySignup()),
    );
  }
}

class BodySignup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/images/logo-png.png",
            height: size.height * 0.26,
          ),
          Text(
            "ĐĂNG KÝ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 10),
          RoundedField(
            hintText: "Nhập email của bạn...",
            icon: Icons.person,
            controller: _emailController,
            fieldPurpose: FieldPurpose.signup,
            onEditingComplete: () {
              _userController.emailValue = _emailController.text;
            },
          ),
          RoundedPass(
            textEditingController: _passwordController,
            fieldPurpose: FieldPurpose.signup,
          ),
          const SizedBox(height: 8),
          RoundedButton(),
          const SizedBox(height: 10),
          AccountCheck(
            login: false,
            press: () {
              Get.toNamed("/login");
            },
          ),
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  final Widget child;
  const Background({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/signup_top.png",
              width: size.width * 0.5,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_bottom.png",
              width: size.width * 0.2,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/login_bottom.png",
              width: size.width * 0.5,
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding:
            const EdgeInsets.only(top: 17, bottom: 17, left: 110, right: 110),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Colors.pink.shade100,
      ),
      onPressed: () {
        final email = _emailController.text;
        final password = _passwordController.text;
        _userController.userRegister(email, password);
      },
      child: const Text(
        " Đăng Ký",
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}
