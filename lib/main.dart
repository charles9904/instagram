import 'package:flukit/widgets/app.dart';
import 'package:flutter/material.dart';

import 'configs/routes.dart';
import 'configs/settings.dart';
import 'configs/themes.dart';

void main() {
  runApp(const Instagram());
}

class Instagram extends StatelessWidget {
  const Instagram({super.key});

  @override
  Widget build(BuildContext context) {
    return FluMaterialApp(
      title: settings.appName,
      color: settings.defaultTheme.colorSchemeSeed,
      theme: themeManager.lightTheme,
      darkTheme: themeManager.darkTheme,
      getPages: router.pages,
      initialRoute: router.getRouteName(Routes.splash),
      debugShowCheckedModeBanner: false,
    );
  }
}
