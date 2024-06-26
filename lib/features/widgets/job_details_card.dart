import 'package:discover_training_location/features/widgets/custom_progress_indicator.dart';
import 'package:discover_training_location/features/widgets/jobs_card.dart';
import 'package:discover_training_location/themes/color_styles.dart';
import 'package:discover_training_location/controllers/controller.dart';
import 'package:discover_training_location/controllers/data_controller.dart';
import 'package:discover_training_location/constants/dimensions.dart';
import 'package:discover_training_location/themes/font_styles.dart';
import 'package:discover_training_location/constants/named_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobDetailsCard extends StatelessWidget {
  const JobDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final Controller tabSwitchController = Get.put(Controller());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Discover Training',
          style: TextStyle(
            color: ColorStyles.darkTitleColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorStyles.pureWhite,
      ),
      body: GetBuilder<DataController>(
        init: DataController(),
        builder: (data) {
          return FutureBuilder(
            future: data.fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final jobs = data.jobsData;
                return RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(
                      const Duration(seconds: 2),
                      () {
                        tabSwitchController.currentIndex = 3;
                        tabSwitchController.switchScreen();
                      },
                    );
                  },
                  child: ListView.builder(
                    itemCount: jobs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          Get.toNamed(
                            NamedRoutes.fullPageJob,
                            arguments: jobs[index],
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: scaleHeight(10, context),
                            horizontal: scaleWidth(12, context),
                          ),
                          child: JobsCard(
                            dataModel: jobs[index],
                            color: index % 2 == 0
                                ? ColorStyles.c5386E4
                                : const Color(0xFF3A5C99),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'Error fetching the jobs!',
                    style: FontStyles.boldStyle,
                  ),
                );
              }

              return const CustomProgressIndicator();
            },
          );
        },
      ),
    );
  }
}
