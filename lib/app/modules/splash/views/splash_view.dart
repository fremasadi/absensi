import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GetBuilder<SplashController>(
          builder: (controller) {
            return AnimatedBuilder(
              animation: controller.animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: 1.0 - controller.animationController.value / 2,
                  child: Transform.translate(
                    offset: Offset(0, controller.animation.value),
                    child: Image.asset(
                      'assets/images/img_logo.png',
                      width: 250.w,
                      height: 250.h,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
