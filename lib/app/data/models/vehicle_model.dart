import 'package:cloud_firestore/cloud_firestore.dart';

class VehicleModel {
  String? documentId;
  final String name;
  final String number;
  final String contact;
  final String location;
  final String description;
  final String acType;
  final String vehicleType;
  final String userId;
  final DateTime createdAt;

  VehicleModel({
    this.documentId,
    required this.name,
    required this.number,
    required this.contact,
    required this.location,
    required this.description,
    required this.acType,
    required this.vehicleType,
    required this.userId,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'number': number,
      'contact': contact,
      'location': location,
      'description': description,
      'acType': acType,
      'vehicleType': vehicleType,
      'userId': userId,
      'createdAt': createdAt,
    };
  }

  factory VehicleModel.fromJson(Map<String, dynamic> json, String id) {
    final createdAtValue = json['createdAt'];

    return VehicleModel(
      documentId: id,
      name: json['name'],
      number: json['number'],
      contact: json['contact'],
      location: json['location'],
      description: json['description'],
      acType: json['acType'],
      vehicleType: json['vehicleType'],
      userId: json['userId'],
      createdAt: createdAtValue is Timestamp
          ? createdAtValue.toDate()
          : DateTime.tryParse(createdAtValue) ?? DateTime.now(),
    );
  }
}
