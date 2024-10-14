import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMassage(RemoteMessage message) async {
  // Handle background messages here
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    // Request permission to show notifications
    await _firebaseMessaging.requestPermission();

    // Register the background message handler
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMassage);

    // Get and print the FCM token
    String? token = await _firebaseMessaging.getToken();
    print("FCM Token: $token"); // Print the FCM token for debugging
  }
}
