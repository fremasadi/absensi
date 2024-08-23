import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController
    with SingleGetTickerProviderMixin {
  late final AnimationController animationController;
  late final Animation<double> animation;

  @override
  void onInit() {
    super.onInit();
    // Initialize the AnimationController
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Define the animation
    animation = Tween<double>(begin: 0, end: -300).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Check login status and start the animation
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUserId = prefs.getString('userId');

    // If the user is logged in, show splash and navigate to home page
    print(savedUserId);
    if (savedUserId != null) {
      animationController
          .forward()
          .whenComplete(() => Get.offAllNamed('/base', arguments: savedUserId));
    } else {
      // User is not logged in, navigate to login page directly
      Get.offAllNamed('/login');
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
