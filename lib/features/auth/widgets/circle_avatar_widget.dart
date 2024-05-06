import 'package:flutter/material.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/config/items/app_color.dart';

class CircleAvatarWidget extends StatelessWidget {
  const CircleAvatarWidget({
    super.key,
    required this.icon,
    this.bckColor = AppColor.orange
  });

  final IconData icon;
  final Color? bckColor;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: bckColor,
      radius: context.dynamicWidth(0.18),
      child: Icon(
        icon,
        color: AppColor.lightBlue,
        size: context.dynamicWidth(0.17),
      ),
    );
  }
}