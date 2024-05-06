import 'package:flutter/material.dart';
import 'package:pet_friend_hub_app/config/routes/route_name.dart';
import 'package:pet_friend_hub_app/features/auth/view/profile_screen.dart';
import 'package:pet_friend_hub_app/features/auth/view/sign_in_screen.dart';
import 'package:pet_friend_hub_app/features/auth/view/sign_up_screen.dart';
import 'package:pet_friend_hub_app/features/chat/view/chat_screen.dart';
import 'package:pet_friend_hub_app/features/settings/view/settings.dart';
import 'package:pet_friend_hub_app/features/social_media/view/social_media_screen.dart';
import 'package:pet_friend_hub_app/features/vet_appointment/view/vet_detail.dart';

import '../../features/bottom_bar/view/bottom_bar.dart';

class AppRouter {
  static Route<dynamic>? generate(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteNames.defaultRoute:
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
        );

      case AppRouteNames.signUp:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
        );

      case AppRouteNames.home:
        return MaterialPageRoute(
          builder: (_) => const AppBottomBar(),
        );

      case AppRouteNames.chat:
        return MaterialPageRoute(
          builder: (_) => ChatScreen(),
        );

      case AppRouteNames.social:
        return MaterialPageRoute(
          builder: (_) => const SocialMediaScreen(),
        );

      case AppRouteNames.vet:
        return MaterialPageRoute(
          builder: (_) => const VetDetail(),
        );

      case AppRouteNames.profile:
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
        );

      case AppRouteNames.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen(),);
      default:
        _errorPage();
    }
    return null;
  }

  static Route<dynamic> _errorPage() {
    return MaterialPageRoute(
      builder: (context) {
        return const Scaffold(
          body: Center(
            child: Text(
              'Hata oluştu',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
