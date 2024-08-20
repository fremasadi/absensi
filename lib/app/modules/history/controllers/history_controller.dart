import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class HistoryController extends GetxController {
  DateTime currentDate = DateTime.now();
  DateTime selectedYear = DateTime.now();
  final isView = false.obs;
  final userId = ''.obs;
  RxString selectedMonthName = "".obs;
  RxList<DateTime> monthsOfYear = <DateTime>[].obs;
  var initialIndex = 0.obs;
  late AutoScrollController autoScrollC;
  var isLoading = true.obs;
  var absensiRecords = <Map<String, dynamic>>[].obs;

  var filteredAbsensi = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    userId.value = FirebaseAuth.instance.currentUser!.uid;
    initialize();
  }

  void initialize() {
    updateMonthsOfYear();
    selectedMonthName.value = DateFormat('MMMM yyyy').format(currentDate);
    initialIndex.value = currentDate.month - 1;

    if (!isView.value) {
      autoScrollC = AutoScrollController(
        viewportBoundaryGetter: () => const Rect.fromLTRB(10, 0, 10, 0),
        axis: Axis.horizontal,
      );
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToIndex(initialIndex.value);
    });

    // Load absensi records and filter based on current month
    loadAbsensiRecords();
    filterAbsensiByMonth(selectedMonthName.value);

    isView.value = true;
  }

  void loadAbsensiRecords() {
    isLoading.value = true; // Set status loading ke true
    final DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(userId.value)
        .child('absensi');

    databaseReference.once().then((DatabaseEvent event) {
      // Tambahkan delay untuk debugging jika diperlukan
      Future.delayed(Duration(seconds: 2), () {
        List<Map<String, dynamic>> records = [];

        if (event.snapshot.value != null) {
          Map<dynamic, dynamic> data =
              event.snapshot.value as Map<dynamic, dynamic>;

          data.forEach((key, value) {
            if (value != null) {
              Map<String, dynamic> record = Map<String, dynamic>.from(value);
              records.add(record);
            }
          });
        }

        absensiRecords.value = records;
        filterAbsensiByMonth(selectedMonthName.value);
        isLoading.value = false;
      });
    }).catchError((error) {
      Get.snackbar('Error', 'Failed to load data: $error');
      isLoading.value = false; // Set status loading ke false jika terjadi error
    });
  }

  void filterAbsensiByMonth(String monthName) {
    DateTime selectedMonth = DateFormat('MMMM yyyy').parse(monthName);
    int month = selectedMonth.month;
    int year = selectedMonth.year;

    filteredAbsensi.value = absensiRecords.where((record) {
      DateTime absensiDate =
          DateFormat('dd-MM-yyyy').parse(record['waktuAbsen']);
      return absensiDate.month == month && absensiDate.year == year;
    }).toList();

    // Urutkan berdasarkan tanggal waktuAbsen dari yang terbesar (terbaru) ke yang terkecil (terlama)
    filteredAbsensi.sort((a, b) {
      DateTime dateA = DateFormat('dd-MM-yyyy').parse(a['waktuAbsen']);
      DateTime dateB = DateFormat('dd-MM-yyyy').parse(b['waktuAbsen']);
      return dateB.compareTo(dateA); // Ubah urutan pengembalian di sini
    });
  }

  void updateMonthsOfYear() {
    int year = selectedYear.year;
    monthsOfYear.value =
        List.generate(12, (index) => DateTime(year, index + 1, 1));
  }

  void scrollToIndex(int index) {
    autoScrollC.scrollToIndex(index, preferPosition: AutoScrollPosition.begin);
  }

  void selectMonth(int index) {
    DateTime selectedMonth = monthsOfYear[index];

    if (selectedMonth.isAfter(currentDate)) {
      Get.snackbar(
        'Excuse me',
        'Not yet entered the month you selected.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    initialIndex.value = index;
    selectedMonthName.value = DateFormat('MMMM yyyy').format(selectedMonth);
    filterAbsensiByMonth(selectedMonthName.value);
    scrollToIndex(index);
  }

  void changeYear(int increment) {
    selectedYear = DateTime(selectedYear.year + increment);
    updateMonthsOfYear();

    if (selectedYear.year == currentDate.year) {
      initialIndex.value = currentDate.month - 1;
    } else {
      initialIndex.value = 11;
    }

    selectedMonthName.value =
        DateFormat('MMMM yyyy').format(monthsOfYear[initialIndex.value]);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToIndex(initialIndex.value);
    });
  }

  @override
  void onClose() {
    autoScrollC.dispose();
    super.onClose();
  }

  void showYearPicker(BuildContext context, HistoryController controller) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Select Year',
            style: TextStyle(fontSize: 12.sp),
          ),
          content: SizedBox(
            height: 300.h,
            width: 100.w,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 100, 1),
              lastDate: DateTime(DateTime.now().year, 1),
              initialDate: controller.selectedYear,
              selectedDate: controller.selectedYear,
              onChanged: (DateTime dateTime) {
                bool hasData = checkDataAvailabilityForYear(dateTime);

                if (hasData) {
                  controller.selectedYear = dateTime;
                  controller.updateMonthsOfYear();

                  if (dateTime.year == controller.currentDate.year) {
                    controller.initialIndex.value =
                        controller.currentDate.month - 1;
                  } else {
                    controller.initialIndex.value = 11;
                  }

                  controller.selectedMonthName.value = DateFormat('MMMM yyyy')
                      .format(controller
                          .monthsOfYear[controller.initialIndex.value]);
                  controller.filterAbsensiByMonth(controller
                      .monthsOfYear[controller.initialIndex.value].month
                      .toString());
                  Get.back();
                } else {
                  Get.snackbar(
                    'Data Not Available',
                    'There is no data for the year ${dateTime.year}.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  bool checkDataAvailabilityForYear(DateTime dateTime) {
    List<int> availableYears = [2021, 2022, 2023, 2024];
    return availableYears.contains(dateTime.year);
  }
}
