class Training {
  final String id;
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

  Training({
    required this.id,
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
  });

  factory Training.fromMap(Map<String, dynamic> map) {
    return Training(
      id: map['id'] ?? '',
      description: map['description'] ?? '',
      responsibilities: map['responsibilities'] ?? '',
      benefits: map['benefits'] ?? '',
      position: map['position'] ?? '',
      locationLink: map['locationLink'] ?? '',
      salary: map['salary'] ?? '',
      duration: map['duration'] ?? '',
      timeWork: map['timeWork'] ?? '',
      typeWork: map['typeWork'] ?? '',
      companyId: map['companyId'] ?? '',
    );
  }
}
