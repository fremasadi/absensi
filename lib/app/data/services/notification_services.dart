import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    // Request permission to show notifications
    await _firebaseMessaging.requestPermission();

    // Register the background message handler
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    // Get and print the FCM token
    String? token = await _firebaseMessaging.getToken();
    print("FCM Token: $token"); // Print the FCM token for debugging
  }

  Future<void> enableNotifications() async {
    // You can add logic here to enable notifications
  }

  Future<void> disableNotifications() async {
    // Delete the FCM token to disable notifications
    await _firebaseMessaging.deleteToken();
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    // Handle background messages here
  }
}
