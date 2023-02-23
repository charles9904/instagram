import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:instagram/models/story.model.dart';

class UserModel {
  final String username;
  final String? profilePicture;
  final bool isVerified;
  final List<StoryModel> stories;

  UserModel({
    required this.username,
    this.profilePicture,
    this.isVerified = false,
    this.stories = const [],
  });

  static List<UserModel> getAll() => [
        UserModel(
          username: 'Rex',
          isVerified: true,
          profilePicture:
              'https://images.pexels.com/photos/6280953/pexels-photo-6280953.jpeg',
          stories: [
            StoryModel(
              media:
                  'https://images.unsplash.com/photo-1620336655055-088d06e36bf0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
              caption:
                  'Temporibus aut voluptatibus beatae nihil aut quasi expedita eaque aut. Sed est quia. Hic qui libero exercitationem numquam dolores vero minus.',
              createdAt: DateTime.parse('2023-02-20 05:10:00'),
            ),
            StoryModel(
              caption:
                  'Temporibus aut voluptatibus beatae nihil aut quasi expedita eaque aut. Sed est quia. Hic qui libero exercitationem numquam dolores vero minus.',
              createdAt: DateTime.parse('2023-02-20 05:10:00'),
            ),
            StoryModel(
              caption:
                  'Non totam qui omnis assumenda voluptatem facere. Vel quae nam molestias pariatur laudantium. Et eius impedit hic aut repellendus aperiam quia recusandae. Sit aut omnis ea aspernatur voluptates voluptate quidem aut quibusdam. Omnis qui accusantium tenetur et cum.',
              colors: [Colors.lightGreen, Colors.greenAccent],
              createdAt: DateTime.parse('2023-02-20 05:10:00'),
            ),
            StoryModel(
              caption:
                  'Molestiae sunt quibusdam. Quia velit natus et ipsum est.',
              createdAt: DateTime.parse('2023-02-20 05:10:00'),
            ),
            StoryModel(
              media:
                  'https://images.unsplash.com/photo-1620336655055-088d06e36bf0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
              caption:
                  'Temporibus aut voluptatibus beatae nihil aut quasi expedita eaque aut. Sed est quia. Hic qui libero exercitationem numquam dolores vero minus.',
              createdAt: DateTime.parse('2023-02-20 05:10:00'),
            ),
            StoryModel(
              caption:
                  'Temporibus aut voluptatibus beatae nihil aut quasi expedita eaque aut. Sed est quia. Hic qui libero exercitationem numquam dolores vero minus.',
              createdAt: DateTime.parse('2023-02-20 05:10:00'),
            ),
          ],
        ),
        UserModel(
          username: 'Delpha',
          stories: [
            StoryModel(
              media:
                  'https://images.unsplash.com/photo-1620336655055-088d06e36bf0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
              caption:
                  'Temporibus aut voluptatibus beatae nihil aut quasi expedita eaque aut. Sed est quia. Hic qui libero exercitationem numquam dolores vero minus.',
              createdAt: DateTime.parse('2023-02-20 05:10:00'),
            ),
          ],
        ),
        UserModel(
          username: 'Hope',
          stories: [
            StoryModel(
              media:
                  'https://images.unsplash.com/photo-1620336655055-088d06e36bf0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
              caption:
                  'Temporibus aut voluptatibus beatae nihil aut quasi expedita eaque aut. Sed est quia. Hic qui libero exercitationem numquam dolores vero minus.',
              createdAt: DateTime.parse('2023-02-20 05:10:00'),
            ),
          ],
        ),
        UserModel(
          username: 'Orlo',
          stories: [
            StoryModel(
              media:
                  'https://images.unsplash.com/photo-1620336655055-088d06e36bf0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
              caption:
                  'Temporibus aut voluptatibus beatae nihil aut quasi expedita eaque aut. Sed est quia. Hic qui libero exercitationem numquam dolores vero minus.',
              createdAt: DateTime.parse('2023-02-20 05:10:00'),
            ),
          ],
        ),
        UserModel(
          username: 'Gerhard',
          stories: [
            StoryModel(
              media:
                  'https://images.unsplash.com/photo-1620336655055-088d06e36bf0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
              caption:
                  'Temporibus aut voluptatibus beatae nihil aut quasi expedita eaque aut. Sed est quia. Hic qui libero exercitationem numquam dolores vero minus.',
              createdAt: DateTime.parse('2023-02-20 05:10:00'),
            ),
          ],
        ),
        UserModel(
          username: 'Reuben',
          stories: [
            StoryModel(
              media:
                  'https://images.unsplash.com/photo-1620336655055-088d06e36bf0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
              caption:
                  'Temporibus aut voluptatibus beatae nihil aut quasi expedita eaque aut. Sed est quia. Hic qui libero exercitationem numquam dolores vero minus.',
              createdAt: DateTime.parse('2023-02-20 05:10:00'),
            ),
          ],
        ),
        UserModel(
          username: 'Oma',
          stories: [
            StoryModel(
              media:
                  'https://images.unsplash.com/photo-1620336655055-088d06e36bf0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
              caption:
                  'Temporibus aut voluptatibus beatae nihil aut quasi expedita eaque aut. Sed est quia. Hic qui libero exercitationem numquam dolores vero minus.',
              createdAt: DateTime.parse('2023-02-20 05:10:00'),
            ),
          ],
        ),
        UserModel(
          username: 'Maynard',
          stories: [
            StoryModel(
              media:
                  'https://images.unsplash.com/photo-1620336655055-088d06e36bf0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
              caption:
                  'Temporibus aut voluptatibus beatae nihil aut quasi expedita eaque aut. Sed est quia. Hic qui libero exercitationem numquam dolores vero minus.',
              createdAt: DateTime.parse('2023-02-20 05:10:00'),
            ),
          ],
        ),
      ];

  static UserModel getRandom() {
    return (getAll()..shuffle())[math.Random().nextInt(getAll().length)];
  }
}
