class BarbershopModel {
  final int id;
  final String name;
  final String email;
  final List<String> openingDays;
  final List<int> openingHours;

  BarbershopModel({
    required this.id,
    required this.name,
    required this.email,
    required this.openingDays,
    required this.openingHours,
  });

  factory BarbershopModel.fromMap(Map<String, dynamic> json) {
    if (json.containsKey('id') &&
        json.containsKey('name') &&
        json.containsKey('email') &&
        json.containsKey('opening_days') &&
        json.containsKey('opening_hours')) {
      return BarbershopModel(
        id: json['id'] as int,
        name: json['name'] as String,
        email: json['email'] as String,
        openingDays: List<String>.from(json['opening_days']),
        openingHours: List<int>.from(json['opening_hours']),
      );
    } else {
      throw ArgumentError('Invalid JSON structure');
    }
  }
}