import 'package:cloud_firestore/cloud_firestore.dart';

class MarkerModel {
  final String name;
  final String type;
  final GeoPoint location;
  final String title;
  final String description;
  final String buttonText;
  final String imagePath;

  MarkerModel({
    required this.name,
    required this.type,
    required this.location,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.imagePath,
  });

  factory MarkerModel.fromDocument(DocumentSnapshot doc) {
    return MarkerModel(
      name: doc['name'],
      type: doc['type'],
      location: doc['location'],
      title: doc['title'],
      description: doc['description'],
      buttonText: doc['buttonText'],
      imagePath: doc['imagePath'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'location': location,
      'title': title,
      'description': description,
      'buttonText': buttonText,
      'imagePath': imagePath,
    };
  }
}
