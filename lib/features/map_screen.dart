import 'dart:async';

import 'package:discover_training_location/constants/assets_location.dart';
import 'package:discover_training_location/controllers/training_controller.dart';
import 'package:discover_training_location/features/full_training.dart';
import 'package:discover_training_location/features/widgets/bottom_sheet_content.dart';
import 'package:discover_training_location/modals/data/full_training_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  MapType _currentMapType = MapType.normal;
  final TrainingController trainingController = Get.find();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    trainingController.fetchTrainings();
  }

  void _changeMapType(MapType newMapType) {
    setState(() {
      _currentMapType = newMapType;
    });
  }

  void _onMarkerTapped(Training training) {
    _showJobDetailsBottomSheet(context, training);
  }

  void _showJobDetailsBottomSheet(BuildContext context, Training training) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetContent(
          title: training.position,
          description: training.description,
          imagePath: Assets.validateCreateTrainig,
          buttonText: 'Show Company',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Obx(() {
        if (trainingController.trainings.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return GoogleMap(
          mapType: _currentMapType,
          initialCameraPosition: const CameraPosition(
            target: LatLng(31.936253047971206, 35.91942764432493),
            zoom: 14.4746,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: trainingController.trainings
              .map((training) => Marker(
                    markerId: MarkerId(training.position),
                    position: LatLng(
                      training.location.latitude,
                      training.location.longitude,
                    ),
                    onTap: () => _onMarkerTapped(training),
                  ))
              .toSet(),
        );
      }),
    );
  }
}
