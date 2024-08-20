import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import '../../../style/app_color.dart';

class ProfileController extends GetxController {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  RxString email = ''.obs;
  RxString instansi = ''.obs;
  RxString jabatan = ''.obs;
  RxString kantor = ''.obs;
  RxString nama = ''.obs;
  RxString profileImageUrl = ''.obs;
  var isExpanded = false.obs;

  // Fungsi untuk toggle ekspansi
  void toggleExpand() {
    isExpanded.value = !isExpanded.value;
  }

  void fetchUserProfile(String userId) async {
    try {
      DatabaseEvent event = await _database.child('users').child(userId).once();
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        print('Data fetched: $data'); // Tambahkan log ini untuk debug

        email.value = data['email'] ?? '';
        instansi.value = data['instansi'] ?? '';
        jabatan.value = data['jabatan'] ?? '';
        kantor.value = data['kantor'] ?? '';
        nama.value = data['nama'] ?? '';
        profileImageUrl.value = data['profileImageUrl'] ?? '';
        print(
            '$profileImageUrl iniadalah imgProfileUrk saya di profile controller'); // Mengambil URL gambar profil
      } else {
        Get.snackbar(
          'Error',
          'User data not found',
          backgroundColor: AppColor.pink,
          colorText: AppColor.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load user data',
        backgroundColor: AppColor.pink,
        colorText: AppColor.white,
      );
      print('Error fetching user profile: $e'); // Log error untuk debug
    }
  }
}
