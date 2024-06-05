import 'package:flutter/material.dart';

import '../../../config/items/app_color.dart';

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
  });

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
        cursorColor: AppColor.whiteColor,
        controller: controller, // Attach the controller to the TextField
        decoration: InputDecoration(
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppColor.whiteColor,
          ),
          fillColor: AppColor.orange,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ));
  }
}