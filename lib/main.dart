import 'package:discover_training_location/app_job_search.dart';
import 'package:discover_training_location/controllers/data_controller.dart';
import 'package:discover_training_location/features/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

//  OneSignal.shared.setAppId('0deac066-5ac1-4639-826b-0157ad75727b');

  Get.put(DataController());
  runApp(const JobSearchApp());
}
