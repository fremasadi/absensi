import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../routes/app_pages.dart';
import '../../../style/app_color.dart';
import '../../../widgets/cards/BottomButtonCard.dart';
import '../../../widgets/cards/pop_up_load.dart';
import '../controllers/absensi_controller.dart';

class AbsensiView extends GetView<AbsensiController> {
  const AbsensiView({super.key});

  @override
  Widget build(BuildContext context) {
    final String address = Get.arguments['address'];
    controller.setAddress(address);
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 38.0),
          child: Obx(() {
            if (controller.isLoading.value) {
              // Display PopUpLoad in the center of the body
              return PopUpLoad(
                alignment: CrossAxisAlignment.center,
                padding: const EdgeInsets.all(20),
                children: [
                  const CircularProgressIndicator(),
                  SizedBox(height: 16.h),
                  Text(
                    'Loading...',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'SemiBold',
                      color: AppColor.primary,
                    ),
                  ),
                ],
              );
            } else if (controller.isAbsenSuccess.value) {
              // Display result when absensi is successful
              return Container(
                width: context.width,
                height: context.height * .8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.sp),
                  color: AppColor.white,
                  border: Border.all(color: AppColor.primary.withOpacity(0.7)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3), // Warna shadow
                      spreadRadius: 2, // Radius sebaran shadow
                      blurRadius: 6, // Radius blur shadow
                      offset: const Offset(0, 4), // Posisi shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16.sp)),
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Image.file(
                          controller.imageFile.value!,
                          width: context.width,
                          height: 253.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 29.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Absence Hours',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: 'Medium',
                            ),
                          ),
                          Text(
                            controller.formattedTime,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColor.grey.withOpacity(0.8),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Check-In Time',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: 'Medium',
                            ),
                          ),
                          Text(
                            controller.formattedDate,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColor.grey.withOpacity(0.8),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Absence Status',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: 'Medium',
                            ),
                          ),
                          Text(
                            controller.statusAbsen.value,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColor.grey.withOpacity(0.8),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Absence Location',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: 'Medium',
                            ),
                          ),
                          Text(
                            address,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColor.grey.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.sp),
                          color: AppColor.white,
                          border: Border.all(
                              color: AppColor.primary.withOpacity(0.7)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () {
                            controller.resetState();
                            Get.toNamed(Routes.BASE);
                          },
                          child: Text(
                            'Back To Home',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'SemiBold',
                              color: AppColor.primary,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              // Display confirmation screen
              return Container(
                padding: EdgeInsets.all(38.sp),
                width: context.width,
                height: context.height * .8 - 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.sp),
                  color: AppColor.white,
                  border: Border.all(color: AppColor.primary.withOpacity(0.7)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Confirm',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: 'Medium',
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Obx(() {
                      return Container(
                        height: 267.h,
                        width: 226.w,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColor.pink),
                          borderRadius: BorderRadius.circular(16),
                          image: controller.imageFile.value != null
                              ? DecorationImage(
                                  image: FileImage(controller.imageFile.value!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: controller.imageFile.value == null
                            ? const Center(child: Text('No image'))
                            : null,
                      );
                    }),
                    SizedBox(height: 16.h),
                    BottomButtonCard(
                      onPressed: controller.repeatPhoto,
                      title: 'Repeat Photo',
                      textStyle: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'SemiBold',
                        color: AppColor.white,
                      ),
                      heightContainer: 40.h,
                      backgroundColor: Colors.red,
                      borderColor: null,
                      radiusBorder: 16,
                    ),
                    SizedBox(height: 16.h),
                    BottomButtonCard(
                      onPressed: controller.isLoading.value
                          ? () {} // Provide an empty function when loading
                          : controller.showStatusDialog,
                      title: controller.isLoading.value ? '' : 'Absence',
                      textStyle: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'SemiBold',
                        color: controller.isLoading.value
                            ? AppColor.grey
                            : AppColor.white,
                      ),
                      heightContainer: 40.h,
                      backgroundColor: controller.isLoading.value
                          ? AppColor.grey
                          : AppColor.green,
                      borderColor: null,
                      radiusBorder: 16,
                    ),
                  ],
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}
