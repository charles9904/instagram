import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

import '../Widgets/logo.dart';
import '../configs/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 8),
        () => router.replace(Routes.auth,
            clearHistory:
                true)); // Delayed to eight seconds to simulate loading.
  }

  @override
  Widget build(BuildContext context) {
    return FluScreen(
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Transform.translate(
                    offset: Offset(0, Flu.screenHeight * .075),
                    child: FluImage(
                      'assets/images/Instagram_Gradient.png',
                      imageSource: ImageSources.asset,
                      height: Flu.screenWidth * .2,
                      width: Flu.screenWidth * .2,
                    ),
                  ),
                ),
              ),
              FluLoader(
                  size: 25,
                  margin: EdgeInsets.only(bottom: Flu.screenHeight * .075)),
              const Logo(),
              SizedBox(height: Flu.screenHeight * .15),
            ],
          ),
        ),
      ),
    );
  }
}
