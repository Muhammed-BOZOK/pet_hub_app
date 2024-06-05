import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pet_friend_hub_app/config/routes/route_name.dart';
import 'package:pet_friend_hub_app/features/auth/view/reset_password_screen.dart';
import 'package:pet_friend_hub_app/features/profile/view/add_pet_screen.dart';
import 'package:pet_friend_hub_app/features/profile/view/detail_post_screen.dart';
import 'package:pet_friend_hub_app/features/profile/view/profile_screen.dart';
import 'package:pet_friend_hub_app/features/auth/view/sign_in_screen.dart';
import 'package:pet_friend_hub_app/features/auth/view/sign_up_screen.dart';
import 'package:pet_friend_hub_app/features/chat/view/chat_screen.dart';
import 'package:pet_friend_hub_app/features/settings/view/settings.dart';
import 'package:pet_friend_hub_app/features/social_media/view/add_posts_screen.dart';
import 'package:pet_friend_hub_app/features/social_media/view/social_media_screen.dart';
import 'package:pet_friend_hub_app/features/vet_and_appointment/view/vet_detail.dart';
import 'package:pet_friend_hub_app/models/data/post_model.dart';
import 'package:pet_friend_hub_app/models/data/vet_clinic_model.dart';

import '../../features/bottom_bar/view/bottom_bar.dart';

class AppRouter {
  static Route<dynamic>? generate(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteNames.signIn:
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
        );

      case AppRouteNames.signUp:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
        );

      case AppRouteNames.resetPassword:
        return MaterialPageRoute(
          builder: (_) => const ResetPassworScreen(),
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
          builder: (_) => SocialMediaScreen(),
        );

      case AppRouteNames.posts:
        final arguments = settings.arguments as Map<dynamic, String>;
        final selectedImage = arguments['selectedImage'] as File;
        return MaterialPageRoute(
          builder: (_) => PostsScreen(
            selectedImage: selectedImage,
          ),
        );

      case AppRouteNames.vetDetail:
        final arguments = settings.arguments as Map<String, dynamic>;
        final vetClinic = arguments['vetClinic'] as VetClinic;
        return MaterialPageRoute(
          builder: (_) => VetDetail(
            vetClinic: vetClinic,
          ),
        );

      case AppRouteNames.profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );

      case AppRouteNames.settings:
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
        );

      case AppRouteNames.addPet:
        return MaterialPageRoute(
          builder: (_) => AddPetScreen(),
        );

      case AppRouteNames.detailPost:
        final arguments = settings.arguments as Map<String, dynamic>;
        final post = arguments['post'] as PostModel;
        final userProfilePhoto = arguments['userProfilPhoto'] as String;
        return MaterialPageRoute(
          builder: (_) => DetailPostScreen(
            post: post,
            userProfilePhoto: userProfilePhoto,
          ),
        );

      default:
         return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
        );
    }
  }

//   static Route<dynamic> _errorPage() {
//     return MaterialPageRoute(
//       builder: (context) {
//         return const Scaffold(
//           body: Center(
//             child: Text(
//               'Hata oluştu',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         );
//       },
//     );
//   }

}
