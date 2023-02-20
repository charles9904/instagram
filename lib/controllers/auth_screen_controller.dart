import 'package:get/get.dart';

class AuthScreenController extends GetxController {
  final pages = [
    'https://images.unsplash.com/photo-1539187577537-e54cf54ae2f8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=688&q=80',
    'https://images.unsplash.com/photo-1620574695591-42e6f56afb31?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
    'https://images.pexels.com/photos/6280953/pexels-photo-6280953.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
  ];

  final RxInt _currentPage = 0.obs;
  final RxBool _canSubmit = false.obs;

  int get currentPage => _currentPage.value;
  bool get onLastPage => currentPage == (pages.length - 1);
  bool get canSubmit => _canSubmit.value;

  set currentPage(int page) => _currentPage.value = page;
  set canSubmit(bool value) => _canSubmit.value = value;
}
