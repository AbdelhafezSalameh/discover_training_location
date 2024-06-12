import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotifications {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    String? token = await _firebaseMessaging.getToken();

    print("Token: $token");
  }

  void handleMessage(RemoteMessage? message) {
    print(message?.data.toString());
  }
}
