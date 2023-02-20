import 'package:flukit/flukit.dart';
import 'package:flukit/screens/base.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Widgets/logo.dart';
import '../configs/settings.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FluScreen(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: settings.pagePadding.copyWith(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Logo(
                      size:
                          Flu.getTextThemeOf(context).headlineSmall?.fontSize),
                  FluButton.icon(
                    FluIcons.setting2,
                    size: settings.buttonSizeMd,
                    cornerRadius: settings.buttonMdCornerRadius,
                  ),
                ],
              ),
            ),
            Expanded(
              child: FluImage(
                'https://images.unsplash.com/photo-1539187577537-e54cf54ae2f8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=688&q=80',
                margin: settings.pagePadding.copyWith(top: 25),
                cornerRadius: 25,
              ),
            ),
            Padding(
              padding: settings.pagePadding.copyWith(
                  top: Flu.screenHeight * .05, bottom: Flu.screenHeight * .05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dream Big\nEverywhere.',
                    style: GoogleFonts.lexend(
                      textStyle: Flu.getTextThemeOf(context).headlineLarge,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
