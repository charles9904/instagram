import 'dart:math' as math;

class UserModel {
  final String username;
  final String? profilePicture;
  final bool isVerified;

  UserModel({
    required this.username,
    this.profilePicture,
    this.isVerified = false,
  });

  static List<UserModel> getAll() => [
        UserModel(
            username: 'Rex',
            isVerified: true,
            profilePicture:
                'https://images.pexels.com/photos/6280953/pexels-photo-6280953.jpeg'),
        UserModel(username: 'Delpha'),
        UserModel(username: 'Hope'),
        UserModel(username: 'Orlo'),
        UserModel(username: 'Gerhard'),
        UserModel(username: 'Reuben'),
        UserModel(username: 'Oma'),
        UserModel(username: 'Maynard'),
      ];

  static UserModel getRandom() {
    return (getAll()..shuffle())[math.Random().nextInt(getAll().length)];
  }
}
