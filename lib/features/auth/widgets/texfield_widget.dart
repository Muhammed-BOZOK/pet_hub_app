import 'package:flutter/material.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/config/items/app_color.dart';

class TextFromFieldWidget extends StatelessWidget {
  const TextFromFieldWidget({
    super.key,
    this.obscureText = false,
    this.formPreIcon,
    this.suffixIcon,
  });

  final bool obscureText;
  final IconData? formPreIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.dynamicHeight(0.01)),
      child: TextFormField(
        obscureText: obscureText,
        keyboardType: TextInputType.emailAddress,
        decoration: _getDecoration(context),
      ),
    );
  }

  InputDecoration _getDecoration(BuildContext context) {
    Color iconColor = AppColor.lightBlue;

    return InputDecoration(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50), borderSide: BorderSide.none),
      contentPadding: EdgeInsets.symmetric(
        horizontal: context.lowValue,
        vertical: context.dynamicHeight(0.01),
      ),
      prefixIcon: Icon(
        formPreIcon,
        size: 30,
      ),
      prefixIconColor: iconColor,
      filled: true,
      fillColor: AppColor.orange,
      hintText: 'E-mail',
      hintStyle: const TextStyle(
        color: AppColor.whiteColor,
      ),
      suffixIconColor: iconColor,
      suffixIcon: suffixIcon,
    );
  }
}
