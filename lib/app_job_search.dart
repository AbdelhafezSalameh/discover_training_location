import 'package:flutter/material.dart';
import 'package:discover_training_location/themes/color_styles.dart';
import 'package:discover_training_location/themes/font_styles.dart';
import 'package:discover_training_location/constants/get_app_routes.dart';
import 'package:discover_training_location/constants/named_routes.dart';
import 'package:discover_training_location/constants/strings.dart';
import 'package:get/get.dart';

class JobSearchApp extends StatefulWidget {
  const JobSearchApp({super.key});

  @override
  State<JobSearchApp> createState() => _JobSearchAppState();
}

class _JobSearchAppState extends State<JobSearchApp> {
  @override
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: StaticText.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ColorStyles.defaultMainColor,
        fontFamily: FontStyles.fontFamily,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: ColorStyles.darkTitleColor,
          ),
        ),
      ),
      initialRoute: NamedRoutes.splashScreen,
      getPages: GetAppRoutes.getAppRoutes(),
      locale: Get.deviceLocale,
    );
  }
}