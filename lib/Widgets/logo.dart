import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../configs/settings.dart';

class Logo extends StatelessWidget {
  const Logo({this.size, this.color, super.key});

  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${settings.appName.capitalizeFirst!}.',
      style: TextStyle(
        fontSize: size ?? Flu.getTextThemeOf(context).titleLarge?.fontSize,
        fontFamily: 'instagramSans',
        fontWeight: FontWeight.w700,
        color: color ?? Flu.getColorSchemeOf(context).primary,
      ),
    );
  }
}
