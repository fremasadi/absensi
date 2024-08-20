import 'package:absensi/app/modules/history/controllers/history_controller.dart';
import 'package:absensi/app/modules/home/controllers/home_controller.dart';
import 'package:absensi/app/modules/login/controllers/login_controller.dart';
import 'package:absensi/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/base_controller.dart';

class BaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BaseController>(
      () => BaseController(),
    );
    Get.put(HistoryController());
    Get.put(HomeController());
    Get.put(ProfileController());
    Get.put(LoginController());
    Get.put(GoogleMapController);
  }
}
