import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discover_training_location/constants/assets_location.dart';
import 'package:discover_training_location/constants/dimensions.dart';
import 'package:discover_training_location/constants/strings.dart';
import 'package:discover_training_location/features/widgets/popular_jobs_card.dart';
import 'package:discover_training_location/features/widgets/profile_header.dart';
import 'package:discover_training_location/themes/color_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyHomeScreen extends StatefulWidget {
  const CompanyHomeScreen({Key? key}) : super(key: key);

  @override
  State<CompanyHomeScreen> createState() => _CompanyHomeScreenState();
}

class _CompanyHomeScreenState extends State<CompanyHomeScreen> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;
  File? image;
  late String companyName = '';

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < 3) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });

    fetchUserDataFromFirestore();
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
          setState(() {
            companyName = snapshot.get('CompanyName') ?? '';
          });
        }
      } catch (e) {
        print('Error fetching user data from Firestore: $e');
      }
    }
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
              Tab(
                child: Container(
                  height: scaleHeight(50, context),
                  width: scaleWidth(70, context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                        color: const Color.fromARGB(255, 180, 202, 253),
                        width: 1),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child:
                        Text("Active", style: TextStyle(color: Colors.black54)),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  height: scaleHeight(50, context),
                  width: scaleWidth(70, context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                        color: const Color.fromARGB(255, 180, 202, 253),
                        width: 1),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text("Pending",
                        style: TextStyle(color: Colors.black54)),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  height: scaleHeight(50, context),
                  width: scaleWidth(70, context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                        color: Color.fromARGB(177, 244, 67, 54), width: 1),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text("Deleted",
                        style:
                            TextStyle(color: Color.fromARGB(177, 244, 67, 54))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildActiveTabContent(BuildContext context) {
    return Padding(
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
        itemCount: 4,
        itemBuilder: (context, index) {
          return PopularJobsCard(
            logo: index % 2 == 0 ? Assets.googleSvg : Assets.facebookSvg,
            company: index % 2 == 0 ? StaticText.google : StaticText.facebook,
            role: index % 2 == 0 ? 'Sr. Engineer' : 'UI Designer',
            salary: index % 2 == 0 ? '\JD180,000/y' : '\JD110,000/y',
            color1: index % 2 == 0 ? ColorStyles.cEBF1FF : ColorStyles.cFFEBF3,
            color2: index % 2 == 0 ? ColorStyles.cFFEBF3 : ColorStyles.cEBF1FF,
            duration: const Duration(seconds: 2),
          );
        },
      ),
    );
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
                      lightWelcomeText: StaticText.welcomeBackProfile.tr,
                      boldWelcomeText: '$companyName',
                    ),
                  ],
                ),
              ),
              buildTabBar(),
              Expanded(
                child: TabBarView(
                  children: [
                    buildActiveTabContent(context),
                    Center(child: Text('Pending Content')),
                    Center(child: Text('Deleted Content')),
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
