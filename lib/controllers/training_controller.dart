import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discover_training_location/modals/data/full_training_model.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrainingController extends GetxController {
  RxList<Training> trainings = <Training>[].obs;

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
        trainings.value = snapshot.docs
            .map((doc) => Training.fromMap(doc.data() as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      print('Error fetching trainings: $e');
    }
  }

  List<Marker> getMarkers() {
    return trainings.map((training) {
      final GeoPoint location = training.location;
      return Marker(
        markerId: MarkerId(training.position),
        position: LatLng(location.latitude, location.longitude),
        infoWindow: InfoWindow(
          title: training.position,
          snippet: training.description,
        ),
      );
    }).toList();
  }

  Training? getTrainingById(String id) {
    return trainings.firstWhereOrNull((training) => training.position == id);
  }
}
