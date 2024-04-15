import 'package:flutter/material.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/config/items/app_color.dart';

class CustomElevatedButton extends StatelessWidget {
    const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.buttonColor = AppColor.lightBlue,
    this.textColor = AppColor.blacColor,
    this.borderRadius = 8.0,
    this.paddingVertical = 10.0,
    this.paddingHorizontal = 15.0,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color textColor;
  final double borderRadius;
  final double paddingVertical;
  final double paddingHorizontal;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: paddingVertical,
          horizontal: paddingHorizontal,
        ),
        child: Text(
          text,
          style: context.textTheme.titleMedium
        ),
      ),
    );
  }
}
