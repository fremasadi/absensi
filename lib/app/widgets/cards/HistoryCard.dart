import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../style/app_color.dart';

class HistoryCard extends StatelessWidget {
  final String date;
  final String statusAbsen;
  final String waktuAbsen;
  final String keterangan;
  final String locationAbsen;

  const HistoryCard({
    super.key,
    required this.date,
    required this.statusAbsen,
    required this.waktuAbsen,
    required this.keterangan,
    required this.locationAbsen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      margin: EdgeInsets.only(top: 16.sp),
      decoration: BoxDecoration(
        color: AppColor.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tanggal Absensi
            Text(
              date,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'SemiBold',
                color: AppColor.grey,
              ),
            ),
            // Keterangan Absensi
            Text(
              keterangan,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: 'Bold',
                color: AppColor.green,
              ),
            ),
            // Status Absensi
            Text(
              'Absence Status : $statusAbsen',
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'SemiBold',
                color: statusAbsen == 'Hadir' ? AppColor.green : Colors.red,
              ),
            ),
            // Waktu Absensi
            Text(
              'Check-In Time : $waktuAbsen',
              style: TextStyle(
                fontFamily: 'Bold',
                fontSize: 10.sp,
                color: AppColor.grey,
              ),
            ),
            Text(
              'Check-In Location : $locationAbsen',
              style: TextStyle(
                fontFamily: 'Bold',
                fontSize: 10.sp,
                color: AppColor.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
