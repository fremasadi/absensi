import 'package:absensi/app/routes/app_pages.dart';
import 'package:absensi/app/style/app_color.dart';
import 'package:absensi/app/widgets/cards/BottomButtonCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID', null);
    String today =
        DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(DateTime.now());

    controller.checkUserAbsenceStatus();
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => controller.isLocationEnabled.value
                ? GoogleMap(
                    onMapCreated: controller.onMapCreated,
                    initialCameraPosition: CameraPosition(
                        target: controller.currentLocation.value, zoom: 50),
                    markers: controller.markers.toSet(),
                    circles: controller.circles.toSet(),
                    // Convert to Set<Circle>
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: false,
                    mapToolbarEnabled: false,
                    compassEnabled: false,
                  )
                : Center(
                    child: Text(
                      'Mohon aktifkan lokasi Anda untuk absen',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0.sp,
                        fontFamily: 'SemiBold',
                        color: AppColor.primary,
                      ),
                    ),
                  ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.all(14.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColor.pink,
              ),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.0.sp, vertical: 8.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          today,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'SemiBold',
                            color: AppColor.grey.withOpacity(0.8),
                          ),
                        ),
                        // Status Absensi
                        Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Status',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontFamily: 'SemiBold',
                                  color: AppColor.grey.withOpacity(0.9),
                                ),
                              ),
                              Text(
                                controller.isUserAlreadyAbsen.value
                                    ? 'Sudah Absen'
                                    : 'Belum Absen',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: 'SemiBold',
                                  color: controller.isUserAlreadyAbsen.value
                                      ? AppColor.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Obx(() {
            // Memeriksa apakah pengguna sudah absen atau tidak bisa absen karena waktu
            if (!controller.isUserAlreadyAbsen.value &&
                controller.canUserAbsent.value) {
              return Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.0.sp, vertical: 8.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Absen Pukul 6 Pagi - 10 Pagi',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'SemiBold',
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 64.0, vertical: 8),
                          child: BottomButtonCard(
                            onPressed: () {
                              Get.toNamed(
                                Routes.ABSENSI,
                                arguments: {
                                  'address': controller.address.value,
                                },
                              );
                            },
                            title: 'Absent Now',
                            textStyle: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'SemiBold',
                              color: AppColor.white,
                            ),
                            heightContainer: 40.h,
                            backgroundColor: AppColor.primary,
                            borderColor: null,
                            radiusBorder: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else if (!controller.canUserAbsent.value) {
              return Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: Text(
                  "Anda tidak dapat absen setelah jam 10 pagi",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return const SizedBox
                  .shrink(); // Tidak menampilkan apa-apa jika sudah absen atau setelah 10 pagi
            }
          }),
        ],
      ),
    );
  }
}
