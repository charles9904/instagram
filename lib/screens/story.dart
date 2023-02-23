import 'package:flukit/flukit.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flukit_icons/icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/configs/themes.dart';

import '../configs/settings.dart';
import '../controllers/story_screen_controller.dart';
import '../models/post.model.dart';
import '../models/story.model.dart';
import '../models/user.model.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen>
    with SingleTickerProviderStateMixin {
  late final StoryScreenController controller;
  late final PageController pageController;
  late final AnimationController animationController;
  late final UserModel user;

  void listenToAnimationChanges() =>
      animationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.stop();
          animationController.reset();

          if (controller.currentStory + 1 < user.stories.length) {
            /// Current story is not the last
            /// so we can move to the next one.
            controller.currentStory += 1;
            loadStory(story: user.stories[controller.currentStory]);
          } else {
            // Out of bounds - loop story
            // You can also Navigator.of(context).pop() here
            controller.currentStory = 0;
            // loadStory(story: stories[currentStory]);

            /// TODO: Get to next story.
            Get.back();
          }
        }
      });

  void loadStory({required StoryModel story, bool animateToPage = true}) {
    animationController.stop();
    animationController.reset();

    if (story.mediaType == PostType.video) {
      /* videoController = null;
      videoController?.dispose();
      videoController = VideoPlayerController.asset(story.media!.url)
        ..initialize().then((_) {
          if (videoController!.value.isInitialized) {
            animationController.duration = videoController!.value.duration;
            videoController!.play();
            // animationController.forward();
          }
        }); */
    } else {
      animationController.duration = Duration(milliseconds: story.duration);
      animationController.forward();
    }

    if (animateToPage) {
      pageController.animateToPage(
        controller.currentStory,
        duration: const Duration(milliseconds: 250),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  void onTapDown(TapUpDetails details, StoryModel story) {
    final double screenWidth = Flu.screenWidth;
    final double dx = details.globalPosition.dx;

    if (dx < screenWidth / 3) {
      if (controller.currentStory - 1 >= 0) {
        controller.currentStory -= 1;
        loadStory(story: user.stories[controller.currentStory]);

        Flu.selectionClickHaptic();
      }
    } else if (dx > 2 * screenWidth / 3) {
      if (controller.currentStory + 1 < user.stories.length) {
        controller.currentStory += 1;
        loadStory(story: user.stories[controller.currentStory]);
      } else {
        // Out of bounds - loop story
        // You can also Navigator.of(context).pop() here
        // currentStory = 0;
        // _loadStory(story: stories[currentStory]);
        Get.back();
      }

      Flu.selectionClickHaptic();
    } else {
      if (story.mediaType == PostType.video) {
        /* if (videoController?.value.isPlaying ?? false) {
          videoController?.pause();
          animationController.stop();
        } else {
          videoController?.play();
          animationController.forward();
        } */

        Flu.selectionClickHaptic();
      }
    }
  }

  void pause() {
    controller.paused = !controller.paused;

    if (controller.paused) {
      animationController.stop();
    } else {
      animationController.forward();
    }
  }

  @override
  void initState() {
    user = Get.arguments;
    controller = Get.find<StoryScreenController>();
    pageController = PageController();
    animationController = AnimationController(vsync: this);
    listenToAnimationChanges();
    loadStory(story: user.stories.first, animateToPage: false);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double appBarButtonSize = 50, appBarButtonCornerRadius = 20;
    final colorScheme = Flu.getColorSchemeOf(context);

    return FluScreen(
      overlayStyle: Flu.getDefaultSystemUiOverlayStyle(context).copyWith(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.black,
          systemNavigationBarIconBrightness: Brightness.light),
      background: Colors.black,
      body: GestureDetector(
        onTapUp: (details) =>
            onTapDown(details, user.stories[controller.currentStory]),
        onLongPressStart: (_) => pause(),
        onLongPressEnd: (_) => pause(),
        child: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: Stack(
              children: [
                PageView.builder(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: user.stories.length,
                  itemBuilder: (context, index) {
                    final story = user.stories[index];

                    if (story.media != null) {
                      if (story.mediaType == PostType.photo) {
                        return FluImage(
                          story.media!,
                          expand: true,
                          overlayOpacity: .65,
                          gradientOverlay: true,
                          gradientOverlayBegin: Alignment.bottomRight,
                          gradientOverlayEnd: Alignment.topLeft,
                        );
                      } else {
                        return Container();
                      }
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        padding: settings.pagePadding,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors:
                                    story.colors ?? colorScheme.gradientColors,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight)),
                        child: Text(
                          story.caption!,
                          textAlign: TextAlign.center,
                          maxLines: 8,
                          overflow: TextOverflow.ellipsis,
                          style: Flu.getTextThemeOf(context)
                              .headlineLarge
                              ?.copyWith(color: Colors.white),
                        ),
                      );
                    }
                  },
                ),
                Padding(
                  padding: settings.pagePadding.copyWith(top: 10),
                  child: Column(
                    children: [
                      Obx(() => Row(
                            children: user.stories
                                .map((story) => _ProgressBar(
                                      animationController: animationController,
                                      position: user.stories.indexOf(story),
                                      currentStory: controller.currentStory,
                                    ))
                                .toList(),
                          )),
                      20.ph,
                      Row(
                        children: [
                          FluAvatar(
                            image: user.profilePicture,
                            size: appBarButtonSize,
                            cornerRadius: appBarButtonCornerRadius,
                            defaultAvatarType: FluAvatarTypes.memojis,
                            margin: const EdgeInsets.only(right: 10),
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    user.username.capitalizeFirst!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (user.isVerified)
                                    const FluIcon(
                                      FluIcons.verify,
                                      size: 16,
                                      strokeWidth: 2,
                                      color: Colors.white,
                                      margin: EdgeInsets.only(left: 5),
                                    )
                                ],
                              ),
                              1.ph,
                              Obx(() => Text(
                                    Flu.timeago(user
                                        .stories[controller.currentStory]
                                        .createdAt),
                                    style: Flu.getTextThemeOf(context)
                                        .bodySmall
                                        ?.copyWith(
                                            color:
                                                Colors.white.withOpacity(.85)),
                                  )),
                            ],
                          )),
                          FluGlass(
                            cornerRadius: appBarButtonCornerRadius,
                            child: FluButton.icon(
                              onPressed: () => Get.back(),
                              FluIcons.multiplyUnicon,
                              iconSize: 16,
                              backgroundColor: Colors.white.withOpacity(.25),
                              foregroundColor: Colors.white,
                              size: appBarButtonSize,
                              cornerRadius: appBarButtonCornerRadius,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const _InputArea(),
                      (Flu.screenHeight * .025).ph
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InputArea extends StatelessWidget {
  const _InputArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color itemBackgroundColor = Colors.white.withOpacity(.25),
        itemForeground = Colors.white;
    final double itemSize = settings.buttonSize - 10,
        itemCornerRadius = settings.buttonMdCornerRadius + 5;

    return Row(
      children: [
        Expanded(
          child: FluGlass(
            intensity: 8.0,
            cornerRadius: itemCornerRadius,
            child: Container(
              height: itemSize,
              decoration: BoxDecoration(color: itemBackgroundColor),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    expands: true,
                    maxLines: null,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(color: itemForeground),
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Send message',
                        hintStyle: Flu.getTextThemeOf(context)
                            .bodySmall
                            ?.copyWith(color: itemForeground.withOpacity(.5)),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12)),
                  )),
                  FluLine(
                    height: 20,
                    width: 1,
                    color: itemForeground.withOpacity(.5),
                  ),
                  FluButton.text(
                    '😍',
                    onPressed: () {},
                    textStyle: const TextStyle(fontSize: 22),
                    height: itemSize,
                    width: itemSize,
                    backgroundColor: Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
        ),
        FluGlass(
          intensity: 8.0,
          cornerRadius: itemCornerRadius,
          margin: const EdgeInsets.only(left: 10),
          child: FluButton.icon(
            FluIcons.send,
            onPressed: () {},
            size: itemSize,
            cornerRadius: itemCornerRadius,
            backgroundColor: itemBackgroundColor,
            foregroundColor: itemForeground,
          ),
        ),
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({
    Key? key,
    required this.animationController,
    required this.position,
    required this.currentStory,
  }) : super(key: key);

  final AnimationController animationController;
  final int currentStory;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: <Widget>[
                FluGlass(
                  child: _buildBar(
                    double.infinity,
                    position < currentStory
                        ? Colors.white
                        : Colors.white.withOpacity(.5),
                  ),
                ),
                position == currentStory
                    ? AnimatedBuilder(
                        animation: animationController,
                        builder: (context, child) {
                          return _buildBar(
                            constraints.maxWidth * animationController.value,
                            Colors.white,
                          );
                        },
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBar(double width, Color color) {
    return Container(
      height: settings.storyProgressBarHeight,
      width: width,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
    );
  }
}
