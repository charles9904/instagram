import 'dart:async';

import 'package:flukit/flukit.dart';
import 'package:flukit/screens/base.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Widgets/logo.dart';
import '../configs/settings.dart';
import 'dart:math' as math;

import '../controllers/auth_screen_controller.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late final AuthScreenController controller;
  late final PageController pageController;
  late final AnimationController animationController;
  late final Animation<double> progressAnimation;

  final animationDuration = const Duration(milliseconds: 400);
  final animationCurve = Curves.decelerate;

  void onMainButtonPressed() {}

  void onInputValueChanged(String value) {
    controller.canSubmit = value.isNotEmpty;
  }

  @override
  void initState() {
    controller = Get.find<AuthScreenController>();
    pageController = PageController();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              if (controller.onLastPage) {
                pageController.jumpToPage(0);
              } else {
                pageController.nextPage(
                    duration: animationDuration, curve: animationCurve);
              }
            }
          })
          ..forward();
    progressAnimation = Tween<double>(begin: 0, end: Flu.screenWidth)
        .animate(animationController);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Flu.getColorSchemeOf(context);

    return FluScreen(
      overlayStyle: Flu.getDefaultSystemUiOverlayStyle(context).copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (value) {
                    controller.currentPage = value;
                    animationController
                      ..reset()
                      ..forward();
                  },
                  itemCount: controller.pages.length,
                  itemBuilder: (context, index) {
                    final page = controller.pages[index];

                    return FluImage(
                      page,
                      expand: true,
                      gradientOverlay: true,
                      overlayOpacity: .85,
                    );
                  },
                ),
                Positioned.fill(
                  child: SafeArea(
                    child: Padding(
                      padding:
                          settings.pagePadding.copyWith(top: 10, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Logo(
                                  size: Flu.getTextThemeOf(context)
                                      .headlineSmall
                                      ?.fontSize,
                                  color: Colors.white),
                              FluButton.icon(
                                FluIcons.setting2,
                                size: settings.buttonSizeMd,
                                cornerRadius: settings.buttonMdCornerRadius,
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.white12,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                  'Voluptatem suscipit sit.',
                                  style: GoogleFonts.spaceMono(
                                    textStyle: Flu.getTextThemeOf(context)
                                        .headlineLarge,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 12),
                                child: SmoothPageIndicator(
                                  count: controller.pages.length,
                                  controller: pageController,
                                  effect: ExpandingDotsEffect(
                                    dotHeight: 3,
                                    dotWidth: 3,
                                    expansionFactor: 8,
                                    radius: 0,
                                    dotColor: Colors.white.withOpacity(.5),
                                    activeDotColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 2,
            alignment: Alignment.centerLeft,
            color: colorScheme.primaryContainer,
            child: AnimatedBuilder(
              animation: progressAnimation,
              builder: (context, child) {
                return Container(
                  height: double.infinity,
                  width: progressAnimation.value,
                  color: colorScheme.primary,
                );
              },
            ),
          ),
          Padding(
            padding: settings.pagePadding.copyWith(
                top: Flu.screenHeight * .035, bottom: Flu.screenHeight * .035),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Dolorem laboriosam quasi sint et omnis tempora odit. Deserunt aut sed.',
                  style: TextStyle(),
                ),
                Container(
                  height: settings.buttonSize,
                  margin: EdgeInsets.only(
                      top: Flu.screenHeight * .025,
                      bottom: !Flu.isKeyboardHidden(context) ? 10 : 0),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(999)),
                  child: TextField(
                    expands: true,
                    maxLines: null,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    textAlignVertical: TextAlignVertical.center,
                    style: Flu.getTextThemeOf(context).bodyMedium,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Your phone number',
                        hintStyle: Flu.getTextThemeOf(context)
                            .bodyMedium
                            ?.copyWith(
                                color: colorScheme.onSurfaceVariant
                                    .withOpacity(.5)),
                        prefixIcon: FluIcon(
                          FluIcons.callAdd,
                          size: 20,
                          color: colorScheme.onSurfaceVariant.withOpacity(.5),
                          margin: const EdgeInsets.only(left: 10),
                        ),
                        suffixIcon: Container(
                          height: 20,
                          width: 20,
                          alignment: Alignment.center,
                          child: FluLine(
                            height: 5,
                            width: 5,
                            radius: 99,
                            color: controller.canSubmit
                                ? Colors.green
                                : Colors.red.shade700,
                          ),
                        )),
                    onChanged: onInputValueChanged,
                  ),
                ),
                if (!Flu.isKeyboardHidden(context))
                  Row(
                    children: [
                      FluButton.text(
                        'Need help?',
                        height: settings.buttonSize,
                        backgroundColor: colorScheme.surfaceVariant,
                        foregroundColor: colorScheme.onSurfaceVariant,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.only(right: 10),
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.normal),
                      ),
                      Expanded(
                        child: FluButton.text(
                          'Get started',
                          onPressed:
                              controller.canSubmit ? onMainButtonPressed : null,
                          prefixIcon: FluIcons.flash,
                          height: settings.buttonSize,
                          block: true,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          backgroundColor: controller.canSubmit
                              ? colorScheme.primary
                              : colorScheme.primaryContainer,
                          foregroundColor: controller.canSubmit
                              ? colorScheme.onPrimary
                              : colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
