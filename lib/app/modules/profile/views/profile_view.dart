import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../style/app_color.dart';
import '../../../widgets/cards/pop_up_load.dart';
import '../../base/controllers/base_controller.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    final BaseController baseController = Get.find<BaseController>();

    return Scaffold(
      body: Obx(() {
        final userId = baseController.userId.value;
        controller.fetchUserProfile(userId);
        if (controller.isLoading.value) {
          // Tampilkan PopUpLoad saat data masih dimuat
          return PopUpLoad(
            children: [
              Column(
                children: [
                  const Center(child: CircularProgressIndicator()),
                  Text('Tunggu...', style: TextStyle(fontSize: 18.sp)),
                ],
              ),
            ],
          );
        } else {
          // Setelah data dimuat, tampilkan konten
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: context.width,
                  padding: EdgeInsets.symmetric(vertical: 16.sp),
                  decoration: BoxDecoration(
                    color: AppColor.pink,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30.sp),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: controller.profileImageUrl.value.isNotEmpty
                                ? NetworkImage(controller.profileImageUrl.value)
                                : const AssetImage(
                                        'assets/images/img_fremas.jpeg')
                                    as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: 80.h,
                        width: 80.w,
                      ),
                      Obx(() => Text(
                            controller.nama.value,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: 'Medium',
                              color: AppColor.black,
                            ),
                          )),
                      Obx(() => Text(
                            controller.jabatan.value,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'Medium',
                              color: AppColor.black,
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'Data Pegawai',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'Medium',
                      color: AppColor.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 48.0, top: 8, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Kantor',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColor.black,
                        ),
                      ),
                      Obx(() => Text(
                            controller.instansi.value,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: AppColor.black,
                            ),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 48.0, top: 8, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lokasi Kantor',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColor.black,
                        ),
                      ),
                      Obx(() => Text(
                            controller.kantor.value,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: AppColor.black,
                            ),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 24),
                  child: Divider(
                    color: AppColor.primary,
                    thickness: 5.h,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'Pusat Bantuan',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'Medium',
                      color: AppColor.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 48.0, top: 8, right: 30),
                  child: Text(
                    'Bantuan',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: AppColor.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 48.0, top: 8, right: 30),
                  child: Text(
                    'Laporkan Masalah',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: AppColor.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 24),
                  child: Divider(
                    color: AppColor.primary,
                    thickness: 5.h,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'About',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'Medium',
                      color: AppColor.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 48.0, top: 8, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Bahasa',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColor.black,
                        ),
                      ),
                      Text(
                        'Indonesia',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColor.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 48.0, top: 8, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'App Versi',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColor.black,
                        ),
                      ),
                      Text(
                        'v.0.0.1',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColor.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 48.0, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tentang Aplikasi',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: AppColor.black,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                size: 22.sp,
                                controller.isExpanded.value
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                              ),
                              onPressed: controller.toggleExpand,
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: controller.isExpanded.value,
                        child: Text(
                          textAlign: TextAlign.center,
                          'Proyek ini merupakan portofolio pribadi saya sendiri, yang mengembangkan aplikasi ini sebagai proyek untuk menunjukkan keterampilan dalam menggunakan teknologi mobile flutter misal mau coba app hubungi saya dan akan saya buatkan usernya.',
                          style: TextStyle(
                              fontSize: 12.0.sp, fontFamily: 'Medium'),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          );
        }
      }),
    );
  }
}
