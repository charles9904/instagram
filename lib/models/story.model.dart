import 'package:flutter/material.dart';
import 'package:instagram/configs/settings.dart';
import 'package:instagram/models/post.model.dart';

class StoryModel {
  StoryModel({
    required this.createdAt,
    this.media,
    this.mediaType = PostType.photo,
    this.caption,
    this.colors,
    int? duration,
  }) : assert(caption != null || media != null) {
    _duration = duration ?? settings.storyDisplayDuration;
  }

  final DateTime createdAt;
  final PostType mediaType;
  final String? media;
  final String? caption;
  final List<Color>? colors;

  late int _duration;

  int get duration => _duration;
}
