import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template_app/controller/login_controller.dart';
import 'package:template_app/widget/home.dart';
import 'package:template_app/widget/register.dart';

enum FieldPurpose {
  login,
  signup,
}

class Login extends GetView<LoginController> {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(child: BodyWelcome()),
    );
  }
}

class BodyWelcome extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
            "ĐĂNG NHẬP",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 10),
          RoundedField(
            hintText: "Nhập email của bạn...",
            icon: Icons.person,
            controller: _emailController,
            fieldPurpose: FieldPurpose.login,
            onEditingComplete: () {
              _loginController.emailValue = _emailController.text;
            },
          ),
          RoundedPass(
            controller: _passwordController,
            fieldPurpose: FieldPurpose.login,
            // onEditingComplete: () {
            //   _loginController.passwordValue = _passwordController.text;
            // },
          ),
          const SizedBox(height: 8),
          RoundedButton(
            press: () {
              String email = _emailController.text;
              String password = _passwordController.text;
              _loginController.loginUser(email, password);
            },
          ),
          const SizedBox(height: 10),
          AccountCheck(
            login: true,
            press: () {
              Get.toNamed("/register");
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
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_top.png",
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

class RoundedField extends StatelessWidget {
  const RoundedField(
      {Key? key,
      required this.hintText,
      required this.icon,
      required this.fieldPurpose,
      required this.controller,
      required this.onEditingComplete})
      : super(key: key);

  final String hintText;
  final IconData icon;
  final FieldPurpose fieldPurpose;
  final TextEditingController controller;
  final void Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        onChanged: (value) {
          if (fieldPurpose == FieldPurpose.login) {
          } else if (fieldPurpose == FieldPurpose.signup) {
            // handle signup case
          }
        },
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.pink.shade50,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.pink.shade100,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}

class RoundedPass extends StatelessWidget {
  const RoundedPass({
    Key? key,
    required this.fieldPurpose,
    required this.controller,
    // required this.onEditingComplete,
  }) : super(key: key);

  final FieldPurpose fieldPurpose;
  final TextEditingController controller;
  // final void Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        controller: controller,
        onChanged: (value) {
          if (fieldPurpose == FieldPurpose.login) {
            // LoginController.loginUser(value, '');
          } else if (fieldPurpose == FieldPurpose.signup) {
            // handle signup case
          }
        },
        // onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          hintText: "Mật khẩu",
          icon: Icon(
            Icons.lock,
            color: Colors.pink.shade50,
          ),
          suffixIcon: Icon(Icons.visibility, color: Colors.pink.shade50),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    this.press,
  }) : super(key: key);

  final void Function()? press;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding:
            const EdgeInsets.only(top: 17, bottom: 17, left: 110, right: 110),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Colors.pink.shade100,
      ),
      onPressed: press,
      child: const Text(
        " Đăng Nhập",
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}

class AccountCheck extends StatelessWidget {
  const AccountCheck({
    Key? key,
    required this.login,
    required this.press,
  }) : super(key: key);

  final bool login;
  final void Function()? press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Bạn chưa có tài khoản ?" : "Bạn đã có tài khoản ?",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Đăng ký" : "Đăng nhập",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
