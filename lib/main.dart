import 'package:discover_training_location/app_job_search.dart';
import 'package:discover_training_location/controllers/data_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   Get.put(DataController());
//   runApp(const JobSearchApp());
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
options: const FirebaseOptions(
    apiKey: 'key',
    appId: 'id',
    messagingSenderId: 'sendid',
    projectId: 'myapp',
    storageBucket: 'myapp-b9yt18.appspot.com',
  )  );
  FirebaseMessaging.instance.getToken().then((value) {
    // ignore: avoid_print
    print('get token: $value');
  });
  Get.put(DataController());
  runApp(const JobSearchApp());
}
