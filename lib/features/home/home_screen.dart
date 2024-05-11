import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discover_training_location/constants/named_routes.dart';
import 'package:discover_training_location/features/widgets/display_card.dart';
import 'package:discover_training_location/features/widgets/horizontal_space.dart';
import 'package:discover_training_location/features/widgets/popular_jobs_card.dart';
import 'package:discover_training_location/features/widgets/profile_header.dart';
import 'package:discover_training_location/features/widgets/search_job.dart';
import 'package:discover_training_location/features/widgets/vetical_space.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:discover_training_location/constants/assets_location.dart';
import 'package:discover_training_location/themes/color_styles.dart';
import 'package:discover_training_location/constants/dimensions.dart';
import 'package:discover_training_location/features/widgets/featured_jobs_tile.dart';

import 'package:discover_training_location/constants/strings.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? image;
  late String fullName = '';

  @override
  void initState() {
    super.initState();
    fetchUserDataFromFirestore();
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
            fullName = snapshot.get('fullName') ?? '';
          });
        }
      } catch (e) {
        // ignore: avoid_print
        print('Error fetching user data from Firestore: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: scaleWidth(24, context),
                  vertical: scaleHeight(28, context),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProfileHeader(
                          // lightWelcomeText: StaticText.welcomeBackProfile.tr,
                          // boldWelcomeText: StaticText.profileName.tr,
                          lightWelcomeText: StaticText.welcomeBackProfile.tr,
                          boldWelcomeText: '$fullName',
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              NamedRoutes.userProfile,
                            ); // Get.defaultDialog(
                            //   title: 'Sign out',
                            //   middleText: 'Do you really want to sign out?',
                            //   textCancel: 'No',
                            //   textConfirm: 'Yes',
                            //   confirmTextColor: ColorStyles.pureWhite,
                            //   onConfirm: () {
                            //     //   AuthFunctions.signOutUser(context);
                            //   },
                            // );
                          },
                          child: Image.asset(
                            Assets.profileImage,
                          ),
                        ),
                      ],
                    ),
                    VerticalSpace(value: 39, ctx: context),
                    const SearchJob(),
                    VerticalSpace(value: 40, ctx: context),
                    const FeaturedJobsTile(
                      mainText: StaticText.featuredJobs,
                      text: StaticText.seeAll,
                    ),
                  ],
                ),
              ),
              HorizontalSpace(value: 20, ctx: context),

              // JOBS CARD
              SizedBox(
                height: scaleHeight(220, context),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return index % 2 == 0
                        ? Padding(
                            padding:
                                EdgeInsets.only(left: scaleWidth(24, context)),
                            child: const DisplayCard(
                              companyName: StaticText.google,
                              role: StaticText.productManager,
                              salary: '\JD200,000/year',
                              location: StaticText.california,
                              color: ColorStyles.c5386E4,
                              logo: Assets.googleSvg,
                            ),
                          )
                        : Padding(
                            padding:
                                EdgeInsets.only(left: scaleWidth(24, context)),
                            child: const DisplayCard(
                              companyName: StaticText.facebook,
                              role: StaticText.softwareEngineer,
                              salary: '\JD180,000/year',
                              location: StaticText.california,
                              color: ColorStyles.defaultMainColor,
                              logo: Assets.facebookSvg,
                            ),
                          );
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(
                  scaleWidth(24, context),
                  scaleHeight(42, context),
                  scaleWidth(24, context),
                  scaleHeight(16, context),
                ),

                // RECOMMENDED JOBS
                child: Column(
                  children: [
                    const FeaturedJobsTile(
                      mainText: StaticText.popularJobs,
                      text: StaticText.seeAll,
                    ),
                    VerticalSpace(
                      value: 20,
                      ctx: context,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PopularJobsCard(
                          logo: Assets.googleSvg,
                          company: StaticText.facebook,
                          role: 'Sr. Engineer',
                          salary: '\JD180,000/y',
                          color: ColorStyles.cFFEBF3,
                        ),
                        PopularJobsCard(
                          logo: Assets.facebookSvg,
                          company: StaticText.facebook,
                          role: 'UI Designer',
                          salary: '\JD110,000/y',
                          color: ColorStyles.cEBF1FF,
                        ),
                      ],
                    ),
                  ],
                ),

                // POPULAR JOBS CARD
              ),
            ],
          ),
        ),
      ),
    );
  }
}
