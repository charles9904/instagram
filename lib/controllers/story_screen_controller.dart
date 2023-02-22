import 'package:get/get.dart';

class StoryScreenController extends GetxController {
  final RxInt _currentStory = 0.obs;
  final RxBool _paused = false.obs;

  int get currentStory => _currentStory.value;
  bool get paused => _paused.value;

  set currentStory(int pos) => _currentStory.value = pos;

  set paused(bool state) => _paused.value = state;
}
