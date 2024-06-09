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
  BitmapDescriptor? customMarkerIcon;

  @override
  void initState() {
    super.initState();
    _loadCustomMarker();
    trainingController.fetchTrainings();
  }

  Future<void> _loadCustomMarker() async {
    final customIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)),
      Assets.binary,
    );
    setState(() {
      customMarkerIcon = customIcon;
    });
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
      body: Obx(() {
        if (trainingController.activeTrainings.isEmpty) {
          return const Center(child: CircularProgressIndicator());
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
          markers: trainingController.activeTrainings
              .map((training) => Marker(
                    markerId: MarkerId(training.position),
                    position: LatLng(
                      training.location.latitude,
                      training.location.longitude,
                    ),
                    icon: customMarkerIcon ?? BitmapDescriptor.defaultMarker,
                    onTap: () => _onMarkerTapped(training),
                  ))
              .toSet(),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 200,
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Normal'),
                      onTap: () {
                        _changeMapType(MapType.normal);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Satellite'),
                      onTap: () {
                        _changeMapType(MapType.satellite);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Hybrid'),
                      onTap: () {
                        _changeMapType(MapType.hybrid);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.layers),
      ),
    );
  }
}
