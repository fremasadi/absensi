import 'package:absensi/app/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../widgets/cards/HistoryCard.dart';
import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.initialize();
    return Scaffold(
      body: Obx(
        () => controller.isView.isFalse
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding:
                    const EdgeInsets.only(left: 12.0, top: 18, bottom: 31.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () =>
                          controller.showYearPicker(context, controller),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          controller.selectedMonthName.value,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 75.h,
                      width: double.infinity,
                      child: ListView.builder(
                        controller: controller.autoScrollC,
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.monthsOfYear.length,
                        itemBuilder: (context, index) {
                          final DateTime month = controller.monthsOfYear[index];
                          return AutoScrollTag(
                            key: ValueKey(index),
                            controller: controller.autoScrollC,
                            index: index,
                            child: InkWell(
                              onTap: () => controller.selectMonth(index),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        index == controller.initialIndex.value
                                            ? Colors.red
                                            : Colors.grey[300],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        DateFormat('MMMM').format(month),
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                          color: index ==
                                                  controller.initialIndex.value
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      Text(
                                        DateFormat('yyyy').format(month),
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: index ==
                                                  controller.initialIndex.value
                                              ? Colors.white
                                              : Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 24.0.sp, left: 12.sp),
                        child: Obx(
                          () {
                            if (controller.isLoading.value) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (controller.filteredAbsensi.isEmpty) {
                              return Center(
                                child: Text(
                                  'Data for this month is missing',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: 'SemiBold',
                                    color: AppColor.grey,
                                  ),
                                ),
                              );
                            } else {
                              return ListView.builder(
                                itemCount: controller.filteredAbsensi.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  final absensi =
                                      controller.filteredAbsensi[index];
                                  return HistoryCard(
                                    date: absensi['waktuAbsen'],
                                    statusAbsen: absensi['statusAbsen']!,
                                    waktuAbsen: absensi['jamAbsen']!,
                                    keterangan: 'Successfully Checked In',
                                    locationAbsen: absensi['lokasiAbsen'],
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
