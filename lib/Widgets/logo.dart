import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../configs/settings.dart';

class Logo extends StatelessWidget {
  const Logo({this.size, this.color, this.alignment, super.key});

  final double? size;
  final Color? color;
  final TextAlign? alignment;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'logo',
      child: Text(
        '${settings.appName.capitalizeFirst!}.',
        textAlign: alignment,
        style: TextStyle(
          fontSize: size ?? Flu.getTextThemeOf(context).titleLarge?.fontSize,
          fontFamily: 'instagramSans',
          fontWeight: FontWeight.w700,
          color: color ?? Flu.getColorSchemeOf(context).primary,
        ),
      ),
    );
  }
}
