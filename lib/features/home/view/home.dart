import 'package:flutter/material.dart';
import 'package:pet_friend_hub_app/constants/color.dart';
import 'package:pet_friend_hub_app/features/auth/view/sign_in_screen.dart';
import 'package:pet_friend_hub_app/features/chat/view/chat_screen.dart';
import 'package:pet_friend_hub_app/features/social_media/view/social_media_screen.dart';
import 'package:pet_friend_hub_app/features/vet_appointment/view/vet_appointment_screen.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PersistentTabController _controller = PersistentTabController(
    initialIndex: 0,
  );

  static final List<Widget> _screens = [
    const SocialMediaScreen(),
    ChatScreen(),
    const VetAppointmentScreen(),
    const SignInScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    double itemIconSize = 30.0;
    Color itemActiveColor = Colors.white;
    final List<PersistentBottomNavBarItem> items = [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_outlined),
        activeColorPrimary: itemActiveColor,
        inactiveColorPrimary: greyColor,
        iconSize: itemIconSize,
      ),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.chat_outlined),
          activeColorPrimary: itemActiveColor,
          inactiveColorPrimary: greyColor,
          iconSize: itemIconSize),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.calendar_month_outlined),
          activeColorPrimary: itemActiveColor,
          inactiveColorPrimary: greyColor,
          iconSize: itemIconSize),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.person_3_outlined),
          activeColorPrimary: itemActiveColor,
          inactiveColorPrimary: greyColor,
          iconSize: itemIconSize),
    ];

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _screens,
      items: items,
      navBarStyle: NavBarStyle.style6,
      confineInSafeArea: true,
      backgroundColor: bottomNavigationBGColor,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }

  // BottomNavigationBar _buildBottomBar() {
  //   List<BottomNavigationBarItem> items = const [
  //     BottomNavigationBarItem(
  //       icon: Icon(Icons.home_outlined),
  //       label: 'home',
  //     ),
  //     BottomNavigationBarItem(
  //       icon: Icon(Icons.chat_outlined),
  //       label: 'home',
  //     ),
  //     BottomNavigationBarItem(
  //       icon: Icon(Icons.calendar_month_outlined),
  //       label: 'home',
  //     ),
  //     BottomNavigationBarItem(
  //       icon: Icon(Icons.person_3_outlined),
  //       label: 'home',
  //     ),
  //   ];

  //   return BottomNavigationBar(
  //     onTap: _onTap,
  //     currentIndex: _currentIndex,
  //     iconSize: 30,
  //     items: items,
  //   );
  // }
}
