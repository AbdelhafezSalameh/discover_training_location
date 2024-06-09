import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discover_training_location/modals/data/full_training_model.dart';
import 'package:get/get.dart';

class TrainingController extends GetxController {
  RxList<Training> activeTrainings = <Training>[].obs;
  RxList<Training> pendingTrainings = <Training>[].obs;

  @override
  void onInit() {
    fetchTrainings();
    super.onInit();
  }

  Future<void> fetchTrainings({String? companyId}) async {
    try {
      Query query = FirebaseFirestore.instance.collection('FeaturedTrainings');

      if (companyId != null) {
        query = query.where('companyId', isEqualTo: companyId);
      }

      final snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        var allTrainings = snapshot.docs
            .map((doc) => Training.fromMap(doc.data() as Map<String, dynamic>))
            .toList();

        activeTrainings.value = allTrainings
            .where((training) => training.isAvailable == 'active')
            .toList();
        pendingTrainings.value = allTrainings
            .where((training) => training.isAvailable == 'pending')
            .toList();
      }
    } catch (e) {
      print('Error fetching trainings: $e');
    }
  }

  Training? getTrainingById(String id) {
    return activeTrainings
            .firstWhereOrNull((training) => training.position == id) ??
        pendingTrainings
            .firstWhereOrNull((training) => training.position == id);
  }
}
