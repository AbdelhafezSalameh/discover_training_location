import 'package:discover_training_location/features/saved_jobs_screen.dart';
import 'package:discover_training_location/features/widgets/job_details_card.dart';
import 'package:discover_training_location/features/home/home_screen.dart';
import 'package:discover_training_location/features/messages/messages_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  final RxInt _currentIndex = 0.obs;
  final List<Widget> _tabs = [
    const HomeScreen(),
    const MessagesScreen(),
    SavedJobsScreen(),
    const JobDetailsCard(),
  ];

  final RxInt _tabController = 0.obs;

  Widget switchScreen() {
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

  set tabController(int index) {
    _tabController.value = index;
  }
}
