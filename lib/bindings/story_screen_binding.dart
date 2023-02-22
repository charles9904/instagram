import 'package:get/get.dart';

import '../controllers/story_screen_controller.dart';

class StoryScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StoryScreenController>(() => StoryScreenController());
  }
}
