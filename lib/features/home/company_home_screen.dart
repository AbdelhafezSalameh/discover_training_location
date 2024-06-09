import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discover_training_location/features/full_training.dart';
import 'package:discover_training_location/modals/data/full_training_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:discover_training_location/controllers/training_controller.dart';
import 'package:discover_training_location/constants/assets_location.dart';
import 'package:discover_training_location/constants/dimensions.dart';
import 'package:discover_training_location/features/widgets/bottom_sheet_content.dart';
import 'package:discover_training_location/features/widgets/popular_jobs_card.dart';
import 'package:discover_training_location/features/widgets/profile_header.dart';
import 'package:discover_training_location/themes/color_styles.dart';

class CompanyHomeScreen extends StatefulWidget {
  const CompanyHomeScreen({Key? key}) : super(key: key);

  @override
  State<CompanyHomeScreen> createState() => _CompanyHomeScreenState();
}

class _CompanyHomeScreenState extends State<CompanyHomeScreen> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;
  String companyName = '';
  final TrainingController trainingController = Get.find();
  String companyId = FirebaseAuth.instance.currentUser?.uid ?? '';

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      setState(() {
        _currentPage = (_currentPage + 1) % 4;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      });
    });

    fetchUserDataFromFirestore();
    trainingController.fetchTrainings(companyId: companyId);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  Future<void> fetchUserDataFromFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (snapshot.exists) {
          final data = snapshot.data();
          setState(() {
            companyName = data?['CompanyName'] ?? 'Unknown Company';
          });
        }
      } catch (e) {
        print('Error fetching user data from Firestore: $e');
      }
    }
  }

  void _showJobDetailsBottomSheet(BuildContext context, Training training) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetContent(
          title: '$companyName\n${training.position}',
          description: training.description,
          imagePath: Assets.validateCreateTrainig,
          buttonText: 'Show Details',
          onTapButton: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullTraining(training: training),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildTabBar() {
    return Material(
      child: Container(
        height: scaleHeight(30, context),
        color: Colors.white,
        child: Align(
          alignment: Alignment.centerLeft,
          child: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            dividerColor: Colors.transparent,
            physics: const ClampingScrollPhysics(),
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color.fromARGB(255, 180, 202, 253),
            ),
            tabs: [
              buildTab("Active", ColorStyles.cEBF1FF, Colors.black54),
              buildTab("Pending", ColorStyles.cEBF1FF, Colors.black54),
              buildTab("Deleted", const Color.fromARGB(177, 244, 67, 54),
                  const Color.fromARGB(177, 244, 67, 54)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTab(String title, Color borderColor, Color textColor) {
    return Tab(
      child: Container(
        height: scaleHeight(50, context),
        width: scaleWidth(70, context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(title, style: TextStyle(color: textColor)),
        ),
      ),
    );
  }

  Widget buildActiveTabContent(BuildContext context) {
    return Obx(() {
      if (trainingController.activeTrainings.isEmpty) {
        return const Center(child: Text('No active trainings available'));
      }
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            scaleWidth(24, context),
            scaleHeight(42, context),
            scaleWidth(24, context),
            scaleHeight(16, context),
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 20.0,
              childAspectRatio: 1,
            ),
            itemCount: trainingController.activeTrainings.length,
            itemBuilder: (context, index) {
              final training = trainingController.activeTrainings[index];
              return GestureDetector(
                onTap: () {
                  _showJobDetailsBottomSheet(context, training);
                },
                child: PopularJobsCard(
                  logo: Assets.googleSvg,
                  company: companyName,
                  role: training.position,
                  salary: training.salary,
                  color1: index % 2 == 0
                      ? ColorStyles.cEBF1FF
                      : ColorStyles.cFFEBF3,
                  color2: index % 2 == 0
                      ? ColorStyles.cFFEBF3
                      : ColorStyles.cEBF1FF,
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ),
      );
    });
  }

  Widget buildPendingTabContent(BuildContext context) {
    return Obx(() {
      if (trainingController.pendingTrainings.isEmpty) {
        return const Center(child: Text('No pending trainings available'));
      }
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            scaleWidth(24, context),
            scaleHeight(42, context),
            scaleWidth(24, context),
            scaleHeight(16, context),
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 20.0,
              childAspectRatio: 1,
            ),
            itemCount: trainingController.pendingTrainings.length,
            itemBuilder: (context, index) {
              final training = trainingController.pendingTrainings[index];
              return GestureDetector(
                onTap: () {
                  _showJobDetailsBottomSheet(context, training);
                },
                child: PopularJobsCard(
                  logo: Assets.googleSvg,
                  company: companyName,
                  role: training.position,
                  salary: training.salary,
                  color1: index % 2 == 0
                      ? ColorStyles.cEBF1FF
                      : ColorStyles.cFFEBF3,
                  color2: index % 2 == 0
                      ? ColorStyles.cFFEBF3
                      : ColorStyles.cEBF1FF,
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: scaleWidth(24, context),
                  vertical: scaleHeight(20, context),
                ),
                child: Row(
                  children: [
                    ProfileHeader(
                      lightWelcomeText: 'Welcome Back,',
                      boldWelcomeText: companyName,
                    ),
                  ],
                ),
              ),
              buildTabBar(),
              Expanded(
                child: TabBarView(
                  children: [
                    buildActiveTabContent(context),
                    buildPendingTabContent(context),
                    const Center(child: Text('Deleted Content')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
