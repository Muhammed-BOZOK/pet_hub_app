import 'package:flutter/material.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/config/items/app_color.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.btnTitle,
    required this.onPressed,
    this.titleStyle,
    this.btnColor = AppColor.lightBlue,
    this.textColor = Colors.black,
    this.borderRadius = 8.0,
    this.paddingVertical = 0,
    this.paddingHorizontal = 15.0,
    this.mrgHorizontal = 5.0,
    this.mrgVertical = 5.0,
  }) : super(key: key);

  final String btnTitle;
  final VoidCallback onPressed;
  final Color btnColor;
  final Color textColor;
  final double borderRadius;
  final double paddingVertical;
  final double paddingHorizontal;
  final double mrgVertical;
  final double mrgHorizontal;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: mrgVertical,
        horizontal: mrgHorizontal,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(btnColor),
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
            btnTitle,
            style: titleStyle ?? context.textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}
