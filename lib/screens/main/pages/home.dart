import 'package:flukit/flukit.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/configs/themes.dart';

import '../../../Widgets/logo.dart';
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
                  _Stories(UserModel.getAll()..shuffle()),
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
    final ColorScheme colorScheme = Flu.getColorSchemeOf(context);
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
              size: avatarSize,
              cornerRadius: avatarRadius,
              margin: EdgeInsets.only(right: avatarSpacing),
            ),
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: users.length,
              itemBuilder: (context, index) {
                return _StoryItem(
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
    super.key,
  });

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
          Row(
            children: [
              Text(
                user?.username.capitalizeFirst ?? 'My Story',
                style: Flu.getTextThemeOf(context).bodySmall?.copyWith(
                    color: colorScheme.onBackground.withOpacity(.65)),
              ),
              if (user?.isVerified ?? false)
                FluIcon(
                  FluIcons.verify,
                  size: 14,
                  style: FluIconStyles.bulk,
                  color: colorScheme.primary,
                  margin: const EdgeInsets.only(left: 3),
                )
            ],
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
    final TextStyle? descTextStyle = Flu.getTextThemeOf(context)
        .bodySmall
        ?.copyWith(color: colorScheme.onSurface.withOpacity(.5));
    final double cornerRadius = 25;
    Widget media;

    if (post.type == PostType.photo) {
      media = FluImage(
        post.content,
        overlayOpacity: .15,
        width: double.infinity,
      );
    } else {
      media = Container();
    }

    return Container(
      margin: margin,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: colorScheme.background,
          borderRadius: BorderRadius.circular(cornerRadius + 5),
          border: Border.all(
              color: colorScheme.outlineVariant.withOpacity(.25), width: 1)),
      child: Column(
        children: [
          Row(
            children: [
              const FluAvatar(
                size: 45,
                margin: EdgeInsets.only(right: 6),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            post.user.username,
                            style: Flu.getTextThemeOf(context)
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        if (post.user.isVerified)
                          FluIcon(
                            FluIcons.verify,
                            size: 16,
                            style: FluIconStyles.bulk,
                            color: colorScheme.primary,
                            margin: const EdgeInsets.only(left: 3),
                          )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          post.location,
                          style: descTextStyle,
                        ),
                        FluLine(
                          height: 3,
                          width: 3,
                          radius: 99,
                          color: colorScheme.primary,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                        ),
                        Text(
                          Flu.timeago(post.postedAt),
                          style: descTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _buildActionIcon(
                context,
                colorScheme,
                FluIcons.more2,
                onPressed: () {},
              ),
            ],
          ),
          8.ph,
          Container(
            clipBehavior: Clip.antiAlias,
            constraints: BoxConstraints(maxHeight: Flu.screenHeight * .45),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(cornerRadius)),
            child: media,
          ),
          8.ph,
          if (post.caption != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  color: colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(30)),
              child: Text(
                post.caption!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            8.ph,
          ],
          Row(
            children: [
              _buildActionIcon(
                context,
                colorScheme,
                FluIcons.heart,
                text: Flu.numberToCompactFormat(post.likes.toDouble()),
                onPressed: () {},
              ),
              5.pw,
              _buildActionIcon(
                context,
                colorScheme,
                FluIcons.messages2,
                text: Flu.numberToCompactFormat(post.comments.toDouble()),
                onPressed: () {},
              ),
              5.pw,
              _buildActionIcon(
                context,
                colorScheme,
                FluIcons.send,
                onPressed: () {},
              ),
              const Spacer(),
              _buildActionIcon(
                context,
                colorScheme,
                FluIcons.bookmark,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionIcon(
      BuildContext context, ColorScheme colorScheme, FluIcons icon,
      {String? text, VoidCallback? onPressed}) {
    final double size = 45;
    final Color backgroundColor = colorScheme.surfaceVariant.withOpacity(.5),
        foregroundColor = colorScheme.onSurfaceVariant.withOpacity(.75);

    if (text != null) {
      return FluButton.text(
        text,
        textStyle: Flu.getTextThemeOf(context)
            .labelSmall
            ?.copyWith(fontWeight: FontWeight.w600, color: foregroundColor),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        prefixIcon: FluIcons.heart,
        iconStrokeWidth: 1.8,
        gap: 5,
        height: size,
        padding: const EdgeInsets.symmetric(horizontal: 10),
      );
    } else {
      return FluButton.icon(
        icon,
        onPressed: onPressed,
        size: size,
        iconStrokeWidth: 1.8,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      );
    }
  }
}
