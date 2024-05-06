import 'package:flutter/material.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/config/items/app_color.dart';

class GoogleBtnViewWidget extends StatelessWidget {
  const GoogleBtnViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.dynamicHeight(0.03)),
      child: Row(
        children: [
          Expanded(
            child: _viewDivider(),
          ),
          InkWell(
            onTap: () {
              debugPrint('Google');
            },
            splashColor: Colors.transparent,
            child: CircleAvatar(
              child: Image.asset('assets/images/google.png'),
            ),
          ),
          Expanded(
            child: _viewDivider(),
          ),
        ],
      ),
    );
  }

  Divider _viewDivider() {
    return const Divider(
      height: 1,
      color: AppColor.greenColor,
    );
  }
}