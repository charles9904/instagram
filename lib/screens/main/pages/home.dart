import 'package:flukit/flukit.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/configs/themes.dart';

import '../../../Widgets/logo.dart';
import '../../../configs/routes.dart';
import '../../../configs/settings.dart';
import '../../../models/post.model.dart';
import '../../../models/user.model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Flu.getColorSchemeOf(context);

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: settings.pagePadding.copyWith(top: 10, bottom: 0),
            child: Row(
              children: [
                _appBarIcon(FluIcons.settings,
                    onPressed: () => Flu.changeThemeMode()),
                Expanded(
                    child: Logo(
                  alignment: TextAlign.center,
                  color: colorScheme.onBackground,
                )),
                _appBarIcon(
                  FluIcons.message,
                  leading: false,
                ),
              ],
            ),
          ),
          Divider(color: colorScheme.outlineVariant.withOpacity(.2)),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.ph,
                  _Stories((UserModel.getAll()
                    ..shuffle()
                    ..removeWhere((user) => user.stories.isEmpty))),
                  _Posts(PostModel.getAll()),
                  50.ph,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _appBarIcon(FluIcons icon,
      {bool leading = true, VoidCallback? onPressed}) {
    final ColorScheme colorScheme = Flu.getColorSchemeOf(context);

    Widget content = FluIcon(
      icon,
      size: 24,
      strokeWidth: 1.8,
      color: Flu.getColorSchemeOf(context).onBackground.withOpacity(.5),
    );

    if (!leading) {
      content = FluBadge(
        offset: const Offset(0, 2),
        position: BadgePosition.bottomRight,
        color: colorScheme.badgeColor,
        boxShadow: [BoxShadow(color: colorScheme.badgeColor, blurRadius: 10)],
        child: content,
      );
    }

    return FluButton(
      onPressed: onPressed,
      alignment: leading ? Alignment.centerLeft : Alignment.centerRight,
      backgroundColor: Colors.transparent,
      height: settings.buttonSizeMd,
      width: settings.buttonSizeMd,
      foregroundColor:
          Flu.getColorSchemeOf(context).onBackground.withOpacity(.5),
      child: content,
    );
  }
}

class _Stories extends StatelessWidget {
  const _Stories(this.users, {Key? key}) : super(key: key);

  final List<UserModel> users;

  @override
  Widget build(BuildContext context) {
    final double avatarSize = Flu.screenWidth * .15,
        avatarRadius = Flu.screenWidth * .07;
    const double avatarSpacing = 15;

    return SizedBox(
        height: avatarSize + 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: settings.pagePadding,
          children: [
            _StoryItem(
              onPressed: () {},
              size: avatarSize,
              cornerRadius: avatarRadius,
              margin: const EdgeInsets.only(right: avatarSpacing),
            ),
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: users.length,
              itemBuilder: (context, index) {
                return _StoryItem(
                  onPressed: () =>
                      router.push(Routes.story, arguments: users[index]),
                  size: avatarSize,
                  user: users[index],
                  cornerRadius: avatarRadius,
                  margin: EdgeInsets.only(left: index == 0 ? 0 : avatarSpacing),
                );
              },
            ),
          ],
        ));
  }
}

class _StoryItem extends StatelessWidget {
  const _StoryItem({
    this.user,
    this.onPressed,
    required this.size,
    required this.cornerRadius,
    this.margin = EdgeInsets.zero,
    Key? key,
  }) : super(key: key);

  final UserModel? user;
  final EdgeInsets margin;
  final double size, cornerRadius;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Flu.getColorSchemeOf(context);

    return FluButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      splashColor: Colors.transparent,
      margin: margin,
      cornerRadius: cornerRadius,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FluAvatar(
            image: user?.profilePicture,
            icon: user != null ? null : FluIcons.plusUnicon,
            size: size,
            cornerRadius: cornerRadius,
            fillColor: colorScheme.outlineVariant.withOpacity(.25),
            defaultAvatarType: FluAvatarTypes.memojis,
            outlined: true,
            outlineGap: 1.5,
            outlineThickness: 2,
            outlineColor: user != null
                ? colorScheme.gradientColors
                : [colorScheme.outlineVariant],
            margin: const EdgeInsets.only(bottom: 5),
          ),
          Text(
            user?.username.capitalizeFirst ?? 'My Story',
            style: Flu.getTextThemeOf(context)
                .bodySmall
                ?.copyWith(color: colorScheme.onBackground.withOpacity(.65)),
          ),
        ],
      ),
    );
  }
}

class _Posts extends StatelessWidget {
  const _Posts(this.posts, {super.key});

  final List<PostModel> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: settings.pagePadding,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return _Post(
          posts[index],
          margin: EdgeInsets.only(top: settings.postSpacing),
        );
      },
    );
  }
}

class _Post extends StatelessWidget {
  const _Post(this.post, {super.key, required this.margin});

  final EdgeInsets margin;
  final PostModel post;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Flu.getColorSchemeOf(context);
    const double cornerRadius = 25, padding = 5;

    Widget media = Container(
      clipBehavior: Clip.antiAlias,
      constraints: BoxConstraints(maxHeight: Flu.screenHeight * .5),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(cornerRadius)),
      child: post.type == PostType.photo
          ? FluImage(
              post.content,
              overlayOpacity: .15,
              width: double.infinity,
            )
          : Container(),
    );

    return Container(
      margin: margin,
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
          color: colorScheme.background,
          borderRadius: BorderRadius.circular(cornerRadius + padding),
          border: Border.all(
              color: colorScheme.outlineVariant.withOpacity(.3), width: 1)),
      child: Column(
        children: [
          media,
          8.ph,
          Row(children: [
            _actionButton(
              context,
              text: Flu.numberToCompactFormat(post.likes.toDouble()),
              icon: FluIcons.heart,
              backgroundColor: colorScheme.badgeColor,
              foregroundColor: Colors.white.withOpacity(.85),
            ),
            2.pw,
            _actionButton(
              context,
              text: Flu.numberToCompactFormat(post.comments.toDouble()),
              icon: FluIcons.messages2,
              backgroundColor: Colors.transparent,
              foregroundColor: colorScheme.onBackground.withOpacity(.5),
            ),
          ]),
          2.ph,
        ],
      ),
    );
  }

  Widget _actionButton(
    BuildContext context, {
    required String text,
    required FluIcons icon,
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    const double actionBtnSize = 45, actionBtnRadius = 24;
    final TextStyle? descTextStyle =
        Flu.getTextThemeOf(context).bodySmall?.copyWith(color: foregroundColor);

    return FluButton.text(
      text,
      prefixIcon: icon,
      iconSize: 18,
      iconStrokeWidth: 2,
      height: actionBtnSize,
      cornerRadius: actionBtnRadius,
      gap: 3,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      textStyle: descTextStyle?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
