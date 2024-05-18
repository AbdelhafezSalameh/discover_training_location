import 'package:get/get.dart';
import 'package:flutter/material.dart';

class FormController extends GetxController {
  // TextEditingControllers for each text field
  TextEditingController descriptionController = TextEditingController();
  TextEditingController responsibilitiesController = TextEditingController();
  TextEditingController benefitsController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController locationLinkController = TextEditingController();
  TextEditingController salaryController = TextEditingController();

  // Variables to hold selected values for dropdowns
  var selectedDuration = '1 Month'.obs;
  var selectedTimeWork = 'Full Time'.obs;
  var selectedTypeWork = 'On Site'.obs;

  // Dropdown items
  final List<String> durationOptions = [
    '1 Month',
    '3 Months',
    '6 Months',
    '1 Year'
  ];
  final List<String> timeWorkOptions = ['Full Time', 'Part Time'];
  final List<String> typeWorkOptions = ['On Site', 'Hybrid', 'Remote'];
}
