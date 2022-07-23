import 'package:flutter_clone_instagram/src/controller/bottom_nav_controller.dart';
import 'package:get/get.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    // permanent: true 옵션 부여하여, 앱을 종료하는 시점까지 계속 state 유지되도록 관리.
    Get.put(BottomNavController(), permanent: true);
  }
}
