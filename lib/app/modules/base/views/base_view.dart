import 'package:absensi/app/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../widgets/cards/BottomButtonCard.dart';
import '../../history/views/history_view.dart';
import '../../home/views/home_view.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/base_controller.dart';

class BaseView extends GetView<BaseController> {
  const BaseView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primary,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.only(left: 16.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.getGreeting(),
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: AppColor.white,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          color: const Color(0x0ff2f2f2),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 75.0),
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 230.h,
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(
                                          height: 32.h,
                                        ),
                                        Center(
                                          child: Text(
                                            'Apakah Kamu Yakin Keluar?',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontFamily: 'Medium',
                                                color: Colors.red,
                                                decoration:
                                                    TextDecoration.none),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 32.h,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 23.0),
                                          child: BottomButtonCard(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            title: 'Tidak',
                                            textStyle: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily: 'SemiBold',
                                              color: AppColor.white,
                                            ),
                                            heightContainer: 45.h,
                                            backgroundColor: AppColor.primary,
                                            borderColor: null,
                                            radiusBorder: 12,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            controller.signOut();
                                          },
                                          child: Text(
                                            'Ya',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily: 'SemiBold',
                                              color: AppColor.black,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.red,
                  size: 28.sp,
                ))
          ],
          bottom: TabBar(
            onTap: controller.onTabTapped,
            tabs: const [
              Tab(text: 'Profile'),
              Tab(text: 'Home'),
              Tab(text: 'History'),
            ],
            labelStyle: TextStyle(
              fontSize: 15.sp,
              fontFamily: 'SemiBold',
              color: AppColor.white,
            ),
            indicatorColor: AppColor.white,
          ),
        ),
        body: const TabBarView(
          children: [
            ProfileView(),
            HomeView(),
            HistoryView(),
          ],
        ),
      ),
    );
  }
}
