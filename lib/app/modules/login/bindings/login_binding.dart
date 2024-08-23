import 'package:absensi/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(ProfileController());
  }
}
