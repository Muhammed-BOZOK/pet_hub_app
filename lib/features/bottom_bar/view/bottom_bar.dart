import 'package:flutter/material.dart';

import '../../profile/view/profile_screen.dart';
import '../../chat/view/chat_screen.dart';
import '../../social_media/view/social_media_screen.dart';
import '../../vet_and_appointment/view/vet_and_appointment_screen.dart';

class AppBottomBar extends StatefulWidget {
  const AppBottomBar({super.key});

  @override
  State<AppBottomBar> createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  // final PersistentTabController _controller = PersistentTabController(
  //   initialIndex: 0,
  // );

  int _selectedIndex = 0;

  static final List<Widget> _screens = [
    SocialMediaScreen(),
    ChatScreen(),
    const VetAppointmentScreen(),
    const ProfileScreen(),
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }

  // Widget _buildBottomBar(BuildContext context) {
  //   double itemIconSize = 30.0;
  //   Color itemActiveColor = Colors.white;
  //   final List<PersistentBottomNavBarItem> items = [
  //     PersistentBottomNavBarItem(
  //       icon: const Icon(Icons.home_outlined),
  //       activeColorPrimary: itemActiveColor,
  //       inactiveColorPrimary: greyColor,
  //       iconSize: itemIconSize,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: const Icon(Icons.chat_outlined),
  //       activeColorPrimary: itemActiveColor,
  //       inactiveColorPrimary: greyColor,
  //       iconSize: itemIconSize,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: const Icon(Icons.calendar_month_outlined),
  //       activeColorPrimary: itemActiveColor,
  //       inactiveColorPrimary: greyColor,
  //       iconSize: itemIconSize,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: const Icon(Icons.person_3_outlined),
  //       activeColorPrimary: itemActiveColor,
  //       inactiveColorPrimary: greyColor,
  //       iconSize: itemIconSize,
  //     ),
  //   ];

  //   return PersistentTabView(
  //     context,
  //     controller: _controller,
  //     screens: _screens,
  //     items: items,
  //     navBarStyle: NavBarStyle.style6,
  //     confineInSafeArea: true,
  //     backgroundColor: bottomNavigationBGColor,
  //     decoration: NavBarDecoration(
  //       borderRadius: BorderRadius.circular(15.0),
  //     ),
  //     resizeToAvoidBottomInset: true,
  //   );
  // }

  Widget _buildBottomBar() {
    List<BottomNavigationBarItem> items = const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        label: 'home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.chat_outlined),
        label: 'home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.calendar_month_outlined),
        label: 'home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_3_outlined),
        label: 'home',
      ),
    ];

    return BottomNavigationBar(
      onTap: _onTap,
      currentIndex: _selectedIndex,
      iconSize: 30,
      items: items,
    );
  }
}
