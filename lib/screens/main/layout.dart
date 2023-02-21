import 'package:flukit/flukit.dart';
import 'package:flukit/widgets/bottom_navigation.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:instagram/configs/settings.dart';

import 'pages/home.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  void onMainButtonPressed() {}

  @override
  Widget build(BuildContext context) {
    return FluScreenWithBottomNav(
      overlayStyle: Flu.getDefaultSystemUiOverlayStyle(context).copyWith(
          systemNavigationBarColor: Flu.getColorSchemeOf(context).surface),
      pages: [
        FluScreenPage(
            icon: FluIcons.home2, label: 'home', content: const HomeScreen()),
        FluScreenPage(
            icon: FluIcons.searchStatus,
            label: 'search',
            content: const HomeScreen()),
        FluScreenPage(
            icon: FluIcons.plus,
            label: 'create',
            onNavigateTo: onMainButtonPressed),
        FluScreenPage(
            icon: FluIcons.heart, label: 'home', content: const HomeScreen()),
        FluScreenPage(
            icon: FluIcons.profile, label: 'home', content: const HomeScreen()),
      ],
      bottomNavBarStyle: FluBottomNavBarStyle(
        height: settings.bottomNavigationBarHeight,
        indicatorSize: 6,
        backgroundColor: Flu.getColorSchemeOf(context).surface,
        padding:
            EdgeInsets.symmetric(horizontal: settings.pagePadding.left * .25),
      ),
    );
  }
}
