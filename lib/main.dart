import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_friend_hub_app/config/items/app_color.dart';
import 'package:pet_friend_hub_app/constants/color.dart';
import 'package:pet_friend_hub_app/features/home/view/home.dart';

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.top
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: AppColor.whiteColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
        ),
        scaffoldBackgroundColor: scaffoldBGColor,
        // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        //   type: BottomNavigationBarType.fixed,
        //   backgroundColor: bottomNavigationBGColor,
        //   unselectedItemColor: greyColor,
        //   selectedItemColor: Colors.white,
        //   showSelectedLabels: false,
        //   showUnselectedLabels: false,
        // ),
        textTheme: const TextTheme(
            headlineSmall: TextStyle(
              color: AppColor.whiteColor,
            ),
            titleLarge: TextStyle(
              fontSize: 24,
              color: AppColor.whiteColor,
            ),
            titleMedium: TextStyle(
              fontSize: 22,
              color: AppColor.whiteColor,
            ),
            bodyLarge: TextStyle(
              fontSize: 22,
              color: AppColor.whiteColor,
            ),
            bodyMedium: TextStyle(
              fontSize: 16,
              color: AppColor.whiteColor,
              letterSpacing: 2,
            ),
            labelLarge: TextStyle(
              fontSize: 16,
              color: AppColor.whiteColor,
            )),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
