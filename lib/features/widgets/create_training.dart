import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discover_training_location/constants/assets_location.dart';
import 'package:discover_training_location/constants/dimensions.dart';
import 'package:discover_training_location/controllers/form_controller%20.dart';
import 'package:discover_training_location/features/auth/data/controllers/validation.dart';
import 'package:discover_training_location/features/auth/presentation/widgets/text_fields.dart';
import 'package:discover_training_location/features/widgets/bottom_sheet_content.dart';
import 'package:discover_training_location/features/widgets/custom_elevated_button%20.dart';
import 'package:discover_training_location/themes/font_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:draggable_home/draggable_home.dart';

class CreateTraining extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final FormController controller = Get.put(FormController());

  CreateTraining({super.key});

  Future<void> saveToFirestore() async {
    if (formKey.currentState!.validate()) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final double latitude =
              double.parse(controller.latitudeController.text);
          final double longitude =
              double.parse(controller.longitudeController.text);
          GeoPoint geoPoint = GeoPoint(latitude, longitude);

          await FirebaseFirestore.instance.collection('FeaturedTrainings').add({
            'description': controller.descriptionController.text,
            'responsibilities': controller.responsibilitiesController.text,
            'benefits': controller.benefitsController.text,
            'position': controller.positionController.text,
            'locationLink': controller.locationLinkController.text,
            'salary': controller.salaryController.text,
            'duration': controller.selectedDuration.value,
            'timeWork': controller.selectedTimeWork.value,
            'typeWork': controller.selectedTypeWork.value,
            'location': geoPoint,
            'companyId': user.uid,
            'isAvailable': "pending",
          });
          Get.snackbar('Success', 'Training created successfully');
          clearTextFields();
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to create training: $e');
      }
    }
  }

  void clearTextFields() {
    controller.descriptionController.clear();
    controller.responsibilitiesController.clear();
    controller.benefitsController.clear();
    controller.positionController.clear();
    controller.locationLinkController.clear();
    controller.salaryController.clear();
    controller.latitudeController.clear();
    controller.longitudeController.clear();
    controller.selectedDuration.value = controller.durationOptions.first;
    controller.selectedTimeWork.value = controller.timeWorkOptions.first;
    controller.selectedTypeWork.value = controller.typeWorkOptions.first;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      title: const Text(
        "Create Training",
        style:
            TextStyle(color: Colors.white, fontFamily: FontStyles.fontFamily),
      ),
      headerWidget: headerWidget(context),
      body: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextField(
                  hintText: 'Description',
                  textIcon: 'assets/icons/description.svg',
                  isPassword: false,
                  textType: TextInputType.text,
                  controller: controller.descriptionController,
                  isErrorfull: false,
                  inputType: InputType.description,
                  formKey: formKey,
                ),
                SizedBox(height: scaleWidth(10, context)),
                CustomTextField(
                  hintText: 'Responsibilities',
                  textIcon: 'assets/icons/responsibilities.svg',
                  isPassword: false,
                  textType: TextInputType.text,
                  controller: controller.responsibilitiesController,
                  isErrorfull: false,
                  inputType: InputType.responsibilities,
                  formKey: formKey,
                ),
                SizedBox(height: scaleWidth(10, context)),
                CustomTextField(
                  hintText: 'Benefits',
                  textIcon: 'assets/icons/benefits.svg',
                  isPassword: false,
                  textType: TextInputType.text,
                  controller: controller.benefitsController,
                  isErrorfull: false,
                  inputType: InputType.benefits,
                  formKey: formKey,
                ),
                SizedBox(height: scaleWidth(10, context)),
                CustomTextField(
                  hintText: 'Position',
                  textIcon: 'assets/icons/position.svg',
                  isPassword: false,
                  textType: TextInputType.text,
                  controller: controller.positionController,
                  isErrorfull: false,
                  inputType: InputType.position,
                  formKey: formKey,
                ),
                SizedBox(height: scaleWidth(10, context)),
                CustomTextField(
                  hintText: 'Location Link',
                  textIcon: 'assets/icons/location.svg',
                  isPassword: false,
                  textType: TextInputType.url,
                  controller: controller.locationLinkController,
                  isErrorfull: false,
                  inputType: InputType.location,
                  formKey: formKey,
                ),
                SizedBox(height: scaleWidth(10, context)),
                CustomTextField(
                  hintText: 'Salary',
                  textIcon: 'assets/icons/salary.svg',
                  isPassword: false,
                  textType: TextInputType.number,
                  controller: controller.salaryController,
                  isErrorfull: false,
                  inputType: InputType.salary,
                  formKey: formKey,
                ),
                SizedBox(height: scaleWidth(10, context)),
                CustomTextField(
                  hintText: 'Latitude',
                  textIcon: 'assets/icons/location.svg',
                  isPassword: false,
                  textType: TextInputType.number,
                  controller: controller.latitudeController,
                  isErrorfull: false,
                  inputType: InputType.location,
                  formKey: formKey,
                ),
                SizedBox(height: scaleWidth(10, context)),
                CustomTextField(
                  hintText: 'Longitude',
                  textIcon: 'assets/icons/location.svg',
                  isPassword: false,
                  textType: TextInputType.number,
                  controller: controller.longitudeController,
                  isErrorfull: false,
                  inputType: InputType.location,
                  formKey: formKey,
                ),
                SizedBox(height: scaleWidth(10, context)),
                Obx(
                  () => DropdownButtonFormField<String>(
                    value: controller.selectedDuration.value,
                    onChanged: (newValue) {
                      controller.selectedDuration.value = newValue!;
                    },
                    items: controller.durationOptions
                        .map((duration) => DropdownMenuItem<String>(
                              value: duration,
                              child: Text(duration),
                            ))
                        .toList(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: scaleWidth(24, context),
                        vertical: scaleHeight(16, context),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: scaleWidth(10, context)),
                Obx(
                  () => DropdownButtonFormField<String>(
                    value: controller.selectedTimeWork.value,
                    onChanged: (newValue) {
                      controller.selectedTimeWork.value = newValue!;
                    },
                    items: controller.timeWorkOptions
                        .map((timeWork) => DropdownMenuItem<String>(
                              value: timeWork,
                              child: Text(timeWork),
                            ))
                        .toList(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: scaleWidth(24, context),
                        vertical: scaleHeight(16, context),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: scaleWidth(10, context)),
                Obx(
                  () => DropdownButtonFormField<String>(
                    value: controller.selectedTypeWork.value,
                    onChanged: (newValue) {
                      controller.selectedTypeWork.value = newValue!;
                    },
                    items: controller.typeWorkOptions
                        .map((typeWork) => DropdownMenuItem<String>(
                              value: typeWork,
                              child: Text(typeWork),
                            ))
                        .toList(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: scaleWidth(24, context),
                        vertical: scaleHeight(16, context),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: scaleWidth(10, context)),
                Obx(
                  () => CustomElevatedButton(
                    ButtonText: 'Create Training',
                    onTapButton: controller.isButtonActive.value
                        ? () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => BottomSheetContent(
                                imagePath: Assets.validateCreateTrainig,
                                title: 'Confirm Training Creation',
                                description:
                                    'Are you sure you want to create training?',
                                onTapButton: () async {
                                  await saveToFirestore();
                                  Navigator.pop(context);
                                },
                                buttonText: 'Confirm',
                              ),
                            );
                          }
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      fullyStretchable: true,
      expandedBody: Container(),
      backgroundColor: Colors.white,
      appBarColor: const Color(0xFF416FDF),
    );
  }

  Widget headerWidget(BuildContext context) {
    return Image.asset(
      Assets.createTrainig,
      fit: BoxFit.cover,
      height: scaleHeight(250, context),
      width: MediaQuery.of(context).size.width,
    );
  }
}
