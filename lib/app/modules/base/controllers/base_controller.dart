import 'package:absensi/app/modules/login/controllers/login_controller.dart';
import 'package:absensi/app/style/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../history/controllers/history_controller.dart';

class BaseController extends GetxController {
  RxInt selectedIndex = 1.obs;
  var isExpanded = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final LoginController loginController = Get.find<LoginController>();

  var userId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    userId.value = Get.arguments as String;
  }

  void toggleAddress() {
    isExpanded.value = !isExpanded.value;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    Get.offAllNamed('/splash'); // Redirect to login page after signing out
  }

  void onTabTapped(int index) {
    selectedIndex.value = index;
    if (index == 0) {
      Get.find<HistoryController>().autoScrollC;
    }
  }

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 6) {
      return 'Selamat pagi';
    } else if (hour < 15) {
      return 'Selamat Siang';
    } else if (hour < 18) {
      return 'Selamat Sore';
    } else {
      return 'Selamat Malam';
    }
  }
}
