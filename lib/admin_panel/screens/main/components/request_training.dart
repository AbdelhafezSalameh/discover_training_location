import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discover_training_location/constants/assets_location.dart';
import 'package:discover_training_location/constants/dimensions.dart';
import 'package:discover_training_location/controllers/training_controller.dart';
import 'package:discover_training_location/features/full_training.dart';
import 'package:discover_training_location/features/widgets/bottom_sheet_content.dart';
import 'package:discover_training_location/features/widgets/popular_jobs_card.dart';
import 'package:discover_training_location/modals/data/full_training_model.dart';
import 'package:discover_training_location/themes/color_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequrstsTrainings extends StatefulWidget {
  static String routeName = "/requrstsTrainings";

  RequrstsTrainings({Key? key}) : super(key: key);

  @override
  State<RequrstsTrainings> createState() => _RequrstsTrainingsState();
}

class _RequrstsTrainingsState extends State<RequrstsTrainings> {
  final TrainingController trainingController = Get.find();
  File? image;
  late String fullName = '';
  String? profileImageUrl;
  bool isLoading = false;
  String companyName = '';

  @override
  void initState() {
    super.initState();
    trainingController.fetchTrainings();
    fetchUserData().then((_) {
      setState(() {});
    });
  }

  void _showJobDetailsBottomSheet(BuildContext context, Training training) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetContent(
          title: training.position,
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
          });
        }
      } catch (e) {
        print('Error fetching user data from Firestore: $e');
      }
    }
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
          if (snapshot.connectionState == ConnectionState.waiting) {
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
                  itemCount: trainingController.pendingTrainings.length,
                  itemBuilder: (context, index) {
                    final training = trainingController.pendingTrainings[index];
                    return GestureDetector(
                      onTap: () {
                        _showJobDetailsBottomSheet(context, training);
                      },
                      onLongPress: () {
                        _updateTrainingStatus(training, 'active');
                      },
                      child: PopularJobsCard(
                        logo: Assets.googleSvg,
                        company: companyName,
                        role: training.position,
                        salary: training.salary,
                        duration: const Duration(seconds: 2),
                        color1: ColorStyles.cFFEBF3,
                        color2: ColorStyles.cFFEBF3,
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

  Future<void> _updateTrainingStatus(
      Training training, String newStatus) async {
    setState(() {
      isLoading = true;
    });

    await trainingController.updateTrainingStatus(training, newStatus);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
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
