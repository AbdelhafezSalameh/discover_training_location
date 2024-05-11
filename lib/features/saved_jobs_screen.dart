import 'package:discover_training_location/constants/dimensions.dart';
import 'package:discover_training_location/constants/named_routes.dart';
import 'package:discover_training_location/features/widgets/custom_progress_indicator.dart';
import 'package:discover_training_location/features/widgets/jobs_card.dart';
import 'package:discover_training_location/themes/color_styles.dart';
import 'package:discover_training_location/themes/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:discover_training_location/controllers/data_controller.dart';
import 'package:get/get.dart';

class SavedJobsScreen extends StatelessWidget {
  SavedJobsScreen({Key? key}) : super(key: key);

  final DataController controller = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Saved Training',
          style: TextStyle(
            color: ColorStyles.darkTitleColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorStyles.pureWhite,
      ),
      body: Center(
        child: FutureBuilder(
          future: controller.fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (controller.savedJobs.value.isEmpty) {
                return const Center(
                  child: Text('No saved jobs!'),
                );
              }
              if (controller.savedJobs.value.isNotEmpty) {
                return Column(
                  children: [
                    Expanded( 
                      child: ListView.builder(
                        itemCount: controller.savedJobs.value.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                NamedRoutes.fullPageJob,
                                arguments: controller.savedJobs.value[index],
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: scaleHeight(10, context),
                                horizontal: scaleWidth(12, context),
                              ),
                              child: JobsCard(
                                dataModel: controller.savedJobs.value[index],
                                color: index % 2 == 0
                                    ? ColorStyles.c5386E4
                                    : const Color(0xFF3A5C99),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
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
        ),
      ),
    );
  }
}
