import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class AbsensiController extends GetxController {
  var imageFile = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();
  var hasAbsen = false.obs;
  var statusAbsen = 'Hadir'.obs;
  var isLoading = false.obs;
  var isAbsenSuccess = false.obs;

  DateTime now = DateTime.now();
  String formattedTime = DateFormat('HH:mm:ss').format(DateTime.now());
  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  var address = ''.obs;

  void setAddress(String newAddress) {
    address.value = newAddress;
  }

  @override
  void onInit() {
    super.onInit();
    openCamera();
  }

  void resetState() {
    isLoading.value = false;
    isAbsenSuccess.value = false;
    imageFile.value = null;
    statusAbsen.value = '';
    formattedTime = '';
    formattedDate = '';
  }

  void showStatusDialog() {
    Get.defaultDialog(
      title: "Select Absence Status",
      titleStyle: TextStyle(fontSize: 16.sp, fontFamily: 'Medium'),
      content: Column(
        children: [
          ListTile(
            title: Text(
              "Present",
              style: TextStyle(
                fontSize: 12.sp,
              ),
            ),
            onTap: () {
              setStatus("Present");
              Get.back();
              absen();
            },
          ),
          ListTile(
            title: Text(
              "Sick",
              style: TextStyle(
                fontSize: 12.sp,
              ),
            ),
            onTap: () {
              setStatus("Sick");
              Get.back();
              absen();
            },
          ),
          ListTile(
            title: Text(
              "Permission",
              style: TextStyle(
                fontSize: 12.sp,
              ),
            ),
            onTap: () {
              setStatus("Permission");
              Get.back();
              absen();
            },
          ),
        ],
      ),
    );
  }

  void absen() async {
    try {
      isLoading.value = true;
      String userId = FirebaseAuth.instance.currentUser!.uid;

      if (imageFile.value != null) {
        String fileName =
            'absensi/$userId/${DateTime.now().millisecondsSinceEpoch}.jpg';
        Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
        UploadTask uploadTask = storageRef.putFile(imageFile.value!);

        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
        String imageUrl = await taskSnapshot.ref.getDownloadURL();

        DatabaseReference userAbsensiRef = FirebaseDatabase.instance
            .ref()
            .child('users')
            .child(userId)
            .child('absensi')
            .push();

        await userAbsensiRef.set({
          'imgSelfie': imageUrl,
          'jamAbsen': formattedTime,
          'waktuAbsen': formattedDate,
          'statusAbsen': statusAbsen.value,
          'lokasiAbsen': address.value,
        });

        hasAbsen.value = true;
        isAbsenSuccess.value = true;
        Get.snackbar('Absence Successful', 'Absence data has been saved');
      } else {
        Get.snackbar('Failed', 'Image not found');
        isAbsenSuccess.value = false;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to save absence data: $e');
      isAbsenSuccess.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  void setStatus(String status) {
    statusAbsen.value = status;
  }

  Future<void> openCamera() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  void repeatPhoto() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }
}
