import 'package:absensi/app/style/app_color.dart';
import 'package:absensi/app/widgets/cards/BottomButtonCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              top: ScreenUtil().screenHeight * 0.1,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SlideTransition(
                    position: controller.logoAnimation!,
                    child: Image.asset(
                      'assets/images/img_logo.png',
                      width: 250.w,
                      height: 250.h,
                    ),
                  ),
                  SlideTransition(
                    position: controller.textAnimation!,
                    child: Opacity(
                      opacity: controller.showTextAndButton.value ? 1.0 : 0.0,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                            child: Text(
                              'Absen Freecode',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontFamily: 'SemiBold',
                                color: AppColor.primary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: TextFormField(
                              controller: controller.emailController,
                              autocorrect: false,
                              onChanged: (value) => controller
                                  .isEmailValid.value = value.isNotEmpty,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColor.primary,
                              ),
                              maxLines: 1,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 17.5, horizontal: 16.0),
                                fillColor: AppColor.pink.withOpacity(0.4),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  fontFamily: 'Medium',
                                  fontSize: 14.sp,
                                  color: AppColor.primary,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Obx(
                              () => TextFormField(
                                controller: controller.passwordController,
                                autocorrect: false,
                                keyboardType: TextInputType.text,
                                obscureText: controller.obscureText.value,
                                onChanged: (value) => controller
                                    .isPasswordValid.value = value.isNotEmpty,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColor.primary,
                                ),
                                maxLines: 1,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 17.5, horizontal: 16.0),
                                  fillColor: AppColor.pink.withOpacity(0.4),
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: '*********',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Medium',
                                    fontSize: 14.sp,
                                    color: AppColor.primary,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.obscureText.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: AppColor.primary,
                                    ),
                                    onPressed:
                                        controller.togglePasswordVisibility,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 48.0.sp),
                            child: Obx(
                              () => controller.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : BottomButtonCard(
                                      onPressed: () {
                                        controller.signIn(
                                          controller.emailController.text
                                              .trim(),
                                          controller.passwordController.text
                                              .trim(),
                                        );
                                      },
                                      title: 'Masuk',
                                      textStyle: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'SemiBold',
                                        color: AppColor.white,
                                      ),
                                      heightContainer: 50.h,
                                      backgroundColor: AppColor.primary,
                                      borderColor: null,
                                      radiusBorder: 16,
                                    ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.SIGNUP);
                            },
                            child: Text(
                              'Daftar',
                              style: TextStyle(
                                fontFamily: 'Medium',
                                fontSize: 12.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
