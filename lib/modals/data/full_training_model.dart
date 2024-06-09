import 'package:cloud_firestore/cloud_firestore.dart';

class Training {
  final String description;
  final String responsibilities;
  final String benefits;
  final String position;
  final String locationLink;
  final String salary;
  final String duration;
  final String timeWork;
  final String typeWork;
  final String companyId;
  final GeoPoint location;
  String isAvailable;

  Training({
    required this.description,
    required this.responsibilities,
    required this.benefits,
    required this.position,
    required this.locationLink,
    required this.salary,
    required this.duration,
    required this.timeWork,
    required this.typeWork,
    required this.companyId,
    required this.location,
    this.isAvailable = 'pending',
  });

  factory Training.fromMap(Map<String, dynamic> map) {
    return Training(
      description: map['description'] ?? '',
      responsibilities: map['responsibilities'] ?? '',
      benefits: map['benefits'] ?? '',
      position: map['position'] ?? '',
      location: map['location'],
      locationLink: map['locationLink'] ?? '',
      salary: map['salary'] ?? '',
      duration: map['duration'] ?? '',
      timeWork: map['timeWork'] ?? '',
      typeWork: map['typeWork'] ?? '',
      companyId: map['companyId'] ?? '',
      isAvailable: map['isAvailable'] ?? 'pending',
    );
  }
}
