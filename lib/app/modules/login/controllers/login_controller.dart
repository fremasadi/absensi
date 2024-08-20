// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:absensi/app/style/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController with SingleGetTickerProviderMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxString userId = ''.obs;

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var showTextAndButton = false.obs;
  AnimationController? animationController;
  Animation<Offset>? textAnimation;
  Animation<Offset>? buttonAnimation;
  Animation<Offset>? logoAnimation;

  var obscureText = true.obs;
  var isEmailValid = false.obs;
  var isPasswordValid = false.obs;

  @override
  void onInit() {
    super.onInit();
    startAnimation();
    emailController.addListener(_onEmailChanged);
    passwordController.addListener(_onPasswordChanged);

    _checkIfLoggedIn();
  }

  @override
  void onClose() {
    emailController.removeListener(_onEmailChanged);
    passwordController.removeListener(_onPasswordChanged);

    // Debugging print statement
    print('Disposing emailController');
    emailController.dispose();

    print('Disposing passwordController');
    passwordController.dispose();

    super.onClose();
  }

  void _onEmailChanged() {
    isEmailValid.value = emailController.text.isNotEmpty;
  }

  void _onPasswordChanged() {
    isPasswordValid.value = passwordController.text.isNotEmpty;
  }

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  Future<void> signIn(String email, String password) async {
    if (!isEmailValid.value || !isPasswordValid.value) {
      Get.snackbar(
        'Maaf',
        'Email dan password harus disi',
        backgroundColor: AppColor.pink,
        colorText: AppColor.white,
      );
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      if (userCredential.user != null) {
        userId.value = userCredential.user!.uid;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', userId.value);
        Get.offAllNamed('/base', arguments: userId.value);
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific errors
      switch (e.code) {
        case 'user-not-found':
          errorMessage.value = 'Email tidak ditemukan';
          break;
        case 'wrong-password':
          errorMessage.value = 'Password salah';
          break;
        case 'invalid-email':
          errorMessage.value = 'Email tidak valid';
          break;
        default:
          errorMessage.value = 'Terjadi kesalahan, coba lagi';
      }

      // Show the snackbar with the error message
      Get.snackbar(
        'Maaf',
        errorMessage.value,
        backgroundColor: Colors.pink,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _checkIfLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUserId = prefs.getString('userId');

    if (savedUserId != null) {
      // User is already logged in, navigate to base page
      Get.offAllNamed('/base', arguments: savedUserId);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    Get.offAllNamed('/login'); // Redirect to login page after signing out
  }

  void startAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Durasi total animasi
    );

    textAnimation = Tween<Offset>(
      begin: Offset(0, 0.5), // Mulai dari bawah
      end: Offset(0, 0), // Ke posisi akhir
    ).animate(CurvedAnimation(
      parent: animationController!,
      curve: Curves.easeInOut,
    ));

    buttonAnimation = Tween<Offset>(
      begin: Offset(0, 0.5), // Mulai dari bawah
      end: Offset(0, 0.2), // Ke posisi akhir
    ).animate(CurvedAnimation(
      parent: animationController!,
      curve: Curves.easeInOut,
    ));

    logoAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      // Mulai dari posisi awal yang lebih dekat dengan posisi akhir
      end: Offset(0, -0.02), // Bergerak ke atas
    ).animate(CurvedAnimation(
      parent: animationController!,
      curve: Curves.easeInOut,
    ));

    Future.delayed(Duration(seconds: 2), () {
      showTextAndButton.value = true;
      animationController!.forward();
    });
  }
}
