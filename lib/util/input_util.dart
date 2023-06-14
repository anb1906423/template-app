import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputUtil {
  static Widget buildInput(String title, String placeholder,
      {TextEditingController? controller, bool disabled = false}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6, bottom: 1),
            child: Text(
              title.tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white, // Màu nền
              borderRadius: BorderRadius.circular(10), // Độ cong của góc
            ),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: placeholder.tr, // Gợi ý nếu input trống
                border: InputBorder.none, // Loại bỏ đường viền mặc định
                contentPadding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16), // Khoảng cách giữa nội dung và viền
              ),
              enabled: !disabled,
              controller: controller,
              // Các thuộc tính khác của TextFormField
            ),
          ),
        ],
      ),
    );
  }
}
