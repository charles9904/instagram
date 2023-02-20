import 'package:get/get.dart';
import '../controllers/auth_screen_controller.dart';

class AuthScreenBinding implements Bindings {
@override
void dependencies() =>
  Get.lazyPut<AuthScreenController>(() => AuthScreenController());
}