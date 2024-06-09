import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discover_training_location/constants/assets_location.dart';
import 'package:discover_training_location/constants/dimensions.dart';
import 'package:discover_training_location/constants/named_routes.dart';
import 'package:discover_training_location/constants/strings.dart';
import 'package:discover_training_location/controllers/training_controller.dart';
import 'package:discover_training_location/features/auth/data/services/firebase/FireBase_Storge.dart';
import 'package:discover_training_location/features/full_training.dart';
import 'package:discover_training_location/features/widgets/bottom_sheet_content.dart';
import 'package:discover_training_location/features/widgets/display_card.dart';
import 'package:discover_training_location/features/widgets/featured_jobs_tile.dart';
import 'package:discover_training_location/features/widgets/popular_jobs_card.dart';
import 'package:discover_training_location/features/widgets/profile_header.dart';
import 'package:discover_training_location/features/widgets/search_job.dart';
import 'package:discover_training_location/features/widgets/vetical_space.dart';
import 'package:discover_training_location/modals/data/full_training_model.dart';
import 'package:discover_training_location/themes/color_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;
  File? image;
  late String fullName = '';
  String? profileImageUrl;
  bool isLoading = false;
  String companyName = '';
  final TrainingController trainingController = Get.find();
  // String companyId = FirebaseAuth.instance.currentUser?.uid ?? '';

  final FirebaseStorageService _storageService = FirebaseStorageService();
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

    profileImageUrl = null;
    trainingController.fetchTrainings();
    fetchUserData().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  Future<void> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (snapshot.exists) {
          setState(() {
            fullName = snapshot.get('fullName') ?? 'user user';
            profileImageUrl = snapshot.get('profileImage') ?? '';

            if (profileImageUrl != null) {}
          });
        }
      } catch (e) {
        // ignore: avoid_print
        print('Error fetching user data from Firestore: $e');
      }
    }
  }

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        isLoading = true;
      });

      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final imageUrl = await _storageService.uploadProfileImage(
              File(pickedFile.path), user.uid);

          if (imageUrl != null) {
            setState(() {
              profileImageUrl = imageUrl;
            });
          }
        }
      } finally {
        setState(() {
          isLoading = false;
        });
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

  Widget buildActiveTabContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        scaleWidth(24, context),
        scaleHeight(20, context),
        scaleWidth(24, context),
        scaleHeight(16, context),
      ),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('FeaturedTrainings')
            .snapshots(),
        builder: (context, snapshot) {
          // trainingController.fetchTrainings(companyId: companyId);

          if (snapshot.connectionState == ConnectionState.waiting) {
            // trainingController.fetchTrainings(companyId: companyId);

            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No trainings available'));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                GridView.builder(
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
              ],
            ),
          );
        },
      ),
    );
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
                          lightWelcomeText: StaticText.welcomeBackProfile.tr,
                          boldWelcomeText: '$fullName',
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(NamedRoutes.userProfile);
                          },
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: scaleHeight(30, context),
                                backgroundColor: Colors.grey[300],
                                child: isLoading
                                    ? const CircularProgressIndicator()
                                    : profileImageUrl != null
                                        ? CircleAvatar(
                                            radius: scaleHeight(30, context),
                                            backgroundImage:
                                                NetworkImage(profileImageUrl!),
                                          )
                                        : null,
                              ),
                            ],
                          ),
                        )
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
              SizedBox(
                height: scaleHeight(190, context),
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: scaleWidth(24, context),
                        right: scaleWidth(24, context),
                      ),
                      child: AnimatedCard(
                        index: index,
                        pageController: _pageController,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  scaleWidth(24, context),
                  scaleHeight(35, context),
                  scaleWidth(24, context),
                  scaleHeight(16, context),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const FeaturedJobsTile(
                      mainText: StaticText.popularJobs,
                      text: StaticText.seeAll,
                    ),
                    buildActiveTabContent(context),
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

class AnimatedCard extends StatelessWidget {
  final int index;
  final PageController pageController;

  const AnimatedCard(
      {Key? key, required this.index, required this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (BuildContext context, Widget? child) {
        double value = 1.0;
        if (pageController.position.haveDimensions) {
          value = pageController.page! - index;
          value = (1 - (value.abs() * 0.2)).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 220,
            width: Curves.easeInOut.transform(value) *
                MediaQuery.of(context).size.width *
                0.8,
            child: child,
          ),
        );
      },
      child: DisplayCard(
        companyName: index % 2 == 0 ? StaticText.google : StaticText.facebook,
        role: index % 2 == 0
            ? StaticText.productManager
            : StaticText.softwareEngineer,
        salary: index % 2 == 0 ? '\JD200,000/year' : '\JD180,000/year',
        location: StaticText.california,
        color:
            index % 2 == 0 ? ColorStyles.c5386E4 : ColorStyles.defaultMainColor,
        logo: index % 2 == 0 ? Assets.googleSvg : Assets.facebookSvg,
      ),
    );
  }
}
