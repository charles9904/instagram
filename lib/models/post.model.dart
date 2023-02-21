import 'user.model.dart';

class PostModel {
  final UserModel user;
  final String location;
  final String content;
  final String? caption;
  final PostType type;
  final DateTime postedAt;
  final int likes;
  final int comments;

  PostModel({
    required this.user,
    required this.content,
    required this.type,
    required this.location,
    required this.postedAt,
    required this.likes,
    required this.comments,
    this.caption,
  });

  static List<PostModel> getAll() => [
        PostModel(
          user: UserModel.getRandom(),
          location: 'Abbyton',
          content:
              'https://images.pexels.com/photos/6280953/pexels-photo-6280953.jpeg',
          caption:
              'Distinctio ducimus deleniti. Et sit omnis. A inventore ut et eos dolores. Assumenda ad consequatur est dolorem veniam minima ratione.',
          type: PostType.photo,
          postedAt: DateTime.parse('2022-07-27 01:10:00'),
          likes: 800000,
          comments: 25000,
        ),
        PostModel(
          user: UserModel.getRandom(),
          location: 'Mount Prospect',
          content:
              'https://images.unsplash.com/photo-1620336655055-088d06e36bf0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
          type: PostType.photo,
          postedAt: DateTime.parse('2023-02-20 05:10:00'),
          likes: 800,
          comments: 150,
        ),
      ];
}

enum PostType { photo, video }
