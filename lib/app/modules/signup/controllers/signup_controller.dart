import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignupController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  final emailController = TextEditingController();
  final namaController = TextEditingController();
  final passwordController = TextEditingController();
  final instansiController = TextEditingController();
  final jabatanController = TextEditingController();
  final kantorController = TextEditingController();

  // Observable property for the selected profile image
  final Rx<File?> _profileImage = Rx<File?>(null);

  File? get profileImage => _profileImage.value;

  set profileImage(File? image) => _profileImage.value = image;

  // Function to pick an image from the gallery
  Future<File?> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path); // Set the selected image
      return profileImage;
    }
    return null;
  }

  // Function to register user with profile image
  Future<void> registerUser(String nama, String email, String password,
      String jabatan, String instansi, String kantor) async {
    try {
      // Create user with email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the current user
      User? user = userCredential.user;

      if (user != null) {
        // Initialize an image URL variable
        String? imageUrl;

        if (profileImage != null) {
          // Upload image to Firebase Storage
          String fileName = 'profile_images/${user.uid}.jpg';
          UploadTask uploadTask =
              _storage.ref().child(fileName).putFile(profileImage!);

          // Get download URL after successful upload
          TaskSnapshot snapshot = await uploadTask;
          imageUrl = await snapshot.ref.getDownloadURL();
        }

        // Store additional data to Realtime Database, including the image URL
        await _database.child('users').child(user.uid).set({
          'nama': nama,
          'email': email,
          'jabatan': jabatan,
          'instansi': instansi,
          'kantor': kantor,
          'profileImageUrl': imageUrl ?? '',
        });

        Get.snackbar('Success', 'User registered successfully!');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
