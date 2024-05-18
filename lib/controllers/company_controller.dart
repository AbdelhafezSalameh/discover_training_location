import 'package:discover_training_location/features/home/company_home_screen.dart';
import 'package:discover_training_location/features/widgets/create_training.dart';
import 'package:discover_training_location/features/widgets/profile_company.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyController extends GetxController {
  final RxInt _currentIndex = 0.obs;
  final List<Widget> _tabs = [
    const CompanyHomeScreen(),
    CreateTraining(),
    CompanyProfile(),
    // const JobDetailsCard(),
  ];

  final RxInt _tabController = 0.obs;
  static CompanyController get to => Get.find();
  Widget CompanyswitchScreen() {
    return _tabs[_currentIndex.value];
  }

  set switchTab(int index) {
    _tabController.value = index;
  }

  int get currentIndex {
    return _currentIndex.value;
  }

  int get tabController {
    return _tabController.value;
  }

  set currentIndex(int index) {
    _currentIndex.value = index;
  }

  // set tabController(int index) {
  //   _tabController.value = index;
  // }
}
