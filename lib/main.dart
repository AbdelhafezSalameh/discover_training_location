import 'package:discover_training_location/app_job_search.dart';
import 'package:discover_training_location/controllers/controller.dart';
import 'package:discover_training_location/controllers/data_controller.dart';
import 'package:discover_training_location/controllers/training_controller.dart';
import 'package:discover_training_location/features/auth/data/controllers/auth_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyDMTG0mFIlVq9QKPmhWcEbhdv4AcUw5ido',
    appId: '1:19223132620:android:05efe0385ce71863ee0569',
    messagingSenderId: '19223132620',
    projectId: 'discover-training-location',
    storageBucket: 'discover-training-location.appspot.com',
  ));
  FirebaseMessaging.instance.getToken().then((value) {
    print('Firebase Cloud Messaging token: $value');
  });
  FirebaseMessaging.instance.getToken().then((value) {
    // ignore: avoid_print
    print('get token: $value');
  });
  Get.put(Controller());
  Get.put(AuthController());

  Get.put(DataController());
  Get.put(TrainingController());
  runApp(const JobSearchApp());
}
