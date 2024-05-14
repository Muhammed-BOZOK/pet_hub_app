import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

import 'config/items/app_color.dart';
import 'config/routes/app_router.dart';
import 'config/routes/route_name.dart';
import 'constants/color.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PET HUB',
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        primaryColor: AppColor.whiteColor,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: AppColor.whiteColor)),
        scaffoldBackgroundColor: scaffoldBGColor,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          backgroundColor: bottomNavigationBGColor,
          unselectedItemColor: greyColor,
          selectedItemColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            color: AppColor.whiteColor,
          ),
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
          titleSmall: TextStyle(
            fontSize: 18,
            color: AppColor.greenColor,
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
          ),
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: AppRouter.generate,
      initialRoute: AppRouteNames.defaultRoute,
    );
  }
}
