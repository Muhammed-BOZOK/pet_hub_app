import 'package:flutter/material.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/constants/color.dart';

class Dneme extends StatelessWidget {
  const Dneme({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: scaffoldBGColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'BU BİR DENEME SAYFASIDIR',
              style: context.textTheme.headlineMedium,
            )
          ],
        ),
      ),
    );
  }
}
