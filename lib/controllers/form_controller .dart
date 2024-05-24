// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class FormController extends GetxController {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController responsibilitiesController = TextEditingController();
  TextEditingController benefitsController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController locationLinkController = TextEditingController();
  TextEditingController salaryController = TextEditingController();

  var selectedDuration = '1 Month'.obs;
  var selectedTimeWork = 'Full Time'.obs;
  var selectedTypeWork = 'On Site'.obs;

  final List<String> durationOptions = [
    '1 Month',
    '3 Months',
    '6 Months',
    '1 Year'
  ];
  final List<String> timeWorkOptions = ['Full Time', 'Part Time'];
  final List<String> typeWorkOptions = ['On Site', 'Hybrid', 'Remote'];
  var isButtonActive = false.obs;

  @override
  void onInit() {
    super.onInit();
    _addListeners();
  }

  void _addListeners() {
    descriptionController.addListener(_validateForm);
    responsibilitiesController.addListener(_validateForm);
    benefitsController.addListener(_validateForm);
    positionController.addListener(_validateForm);
    locationLinkController.addListener(_validateForm);
    salaryController.addListener(_validateForm);
    selectedDuration.listen((_) => _validateForm());
    selectedTimeWork.listen((_) => _validateForm());
    selectedTypeWork.listen((_) => _validateForm());
  }

  void _validateForm() {
    if (descriptionController.text.isNotEmpty &&
        responsibilitiesController.text.isNotEmpty &&
        benefitsController.text.isNotEmpty &&
        positionController.text.isNotEmpty &&
        locationLinkController.text.isNotEmpty &&
        salaryController.text.isNotEmpty &&
        selectedDuration.value.isNotEmpty &&
        selectedTimeWork.value.isNotEmpty &&
        selectedTypeWork.value.isNotEmpty) {
      isButtonActive.value = true;
    } else {
      isButtonActive.value = false;
    }
  }
}
