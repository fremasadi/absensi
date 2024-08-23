import 'dart:io';

import 'package:absensi/app/style/app_color.dart';
import 'package:absensi/app/widgets/cards/BottomButtonCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 22.sp,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Signup',
                style: TextStyle(
                  fontSize: 24.sp,
                  color: AppColor.black,
                  fontFamily: 'Medium',
                ),
              ),
              SizedBox(
                height: 22.h,
              ),
              Obx(
                () => Center(
                  child: GestureDetector(
                    onTap: () async {
                      File? pickedImage = await controller.pickImage();
                      if (pickedImage != null) {
                        controller.update();
                      }
                    },
                    child: CircleAvatar(
                      radius: 50.sp,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: controller.profileImage != null
                          ? FileImage(controller.profileImage!)
                          : null,
                      child: controller.profileImage == null
                          ? Icon(
                              Icons.add_a_photo,
                              size: 50.sp,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                ),
              ),
              Text(
                'Nama',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: 'Medium',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                child: TextFormField(
                  autocorrect: false,
                  controller: controller.namaController,
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
                    hintText: 'Nama',
                    hintStyle: TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 14.sp,
                      color: AppColor.primary,
                    ),
                  ),
                ),
              ),
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: 'Medium',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                child: TextFormField(
                  autocorrect: false,
                  controller: controller.emailController,
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
              Text(
                'Password',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: 'Medium',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                child: TextFormField(
                  autocorrect: false,
                  controller: controller.passwordController,
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
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 14.sp,
                      color: AppColor.primary,
                    ),
                  ),
                ),
              ),
              Text(
                'Instansi',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: 'Medium',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                child: TextFormField(
                  autocorrect: false,
                  controller: controller.instansiController,
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
                    hintText: 'Instansi',
                    hintStyle: TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 14.sp,
                      color: AppColor.primary,
                    ),
                  ),
                ),
              ),
              Text(
                'Jabatan',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: 'Medium',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                child: TextFormField(
                  autocorrect: false,
                  controller: controller.jabatanController,
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
                    hintText: 'Jabatan',
                    hintStyle: TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 14.sp,
                      color: AppColor.primary,
                    ),
                  ),
                ),
              ),
              Text(
                'Kantor',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: 'Medium',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                child: TextFormField(
                  autocorrect: false,
                  controller: controller.kantorController,
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
                    hintText: 'Kantor',
                    hintStyle: TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 14.sp,
                      color: AppColor.primary,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 48.0.sp, vertical: 12.sp),
                child: BottomButtonCard(
                  onPressed: () {
                    final nama = controller.namaController.text.trim();
                    final email = controller.emailController.text.trim();
                    final password = controller.passwordController.text.trim();
                    final instansi = controller.instansiController.text.trim();
                    final jabatan = controller.jabatanController.text.trim();
                    final kantor = controller.kantorController.text.trim();

                    controller.registerUser(
                        nama, email, password, jabatan, instansi, kantor);
                    Get.back();
                  },
                  title: 'Simpan',
                  textStyle: TextStyle(
                    fontSize: 12.sp,
                    color: AppColor.white,
                  ),
                  heightContainer: 45.h,
                  backgroundColor: AppColor.primary,
                  borderColor: null,
                  radiusBorder: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
