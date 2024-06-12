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
        var allTrainings = snapshot.docs.map((doc) {
          return Training.fromMap(doc.id, doc.data() as Map<String, dynamic>);
        }).toList();

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

  Future<void> updateTrainingStatus(Training training, String newStatus) async {
    try {
      await FirebaseFirestore.instance
          .collection('FeaturedTrainings')
          .doc(training.id)
          .update({'isAvailable': newStatus});

      if (newStatus == 'active') {
        pendingTrainings.remove(training);
        activeTrainings.add(training);
      } else if (newStatus == 'pending') {
        activeTrainings.remove(training);
        pendingTrainings.add(training);
      }

      training.isAvailable = newStatus;
    } catch (e) {
      print('Error updating training status: $e');
    }
  }

  Training? getTrainingById(String id) {
    return activeTrainings.firstWhereOrNull((training) => training.id == id) ??
        pendingTrainings.firstWhereOrNull((training) => training.id == id);
  }
}
