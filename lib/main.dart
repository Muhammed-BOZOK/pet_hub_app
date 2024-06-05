import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

import 'config/items/app_color.dart';
import 'config/repository/user_controller_repositry.dart';
import 'config/routes/app_router.dart';
import 'constants/color.dart';
import  'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeData themeData = ThemeData(
    iconTheme: const IconThemeData(
      color: AppColor.whiteColor,
    ),
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
  );
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        String initialRoute =
            ref.read(userControlerRepositoryProvider).isUserSignedIn();

        return MaterialApp(
          title: 'PET HUB',
          theme: themeData,
          onGenerateRoute: AppRouter.generate,
          initialRoute: initialRoute,
        );
      },
    );
  }
}
