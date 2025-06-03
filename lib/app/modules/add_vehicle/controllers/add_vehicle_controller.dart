import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:vehicle_booking/app/data/models/vehicle_model.dart';

class AddVehicleController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  var acVehicle = 2.obs; //
  var vehicleType = 1.obs; // 1 = self, 2 = passenger, 3 = loader, else = bike

  void onACvehicle(int? value) {
    if (value != null) acVehicle.value = value;
  }

  void onChangedVehicleType(int? value) {
    if (value != null) vehicleType.value = value;
  }

  /// Save vehicle globally in shared `vehicles` collection

  Future<void> saveVehicleToFirebase({required String userId}) async {
    try {
      EasyLoading.show(status: 'Saving vehicle...');

      String acType = acVehicle.value == 1 ? "AC" : "NonAC";
      String vehicleTypeText = vehicleType.value == 1
          ? "self"
          : vehicleType.value == 2
              ? "passenger"
              : vehicleType.value == 3
                  ? "loader"
                  : "bike";

      VehicleModel vehicle = VehicleModel(
        name: nameController.text.trim(),
        number: numberController.text.trim(),
        contact: "+92${contactController.text.trim()}",
        location: locationController.text.trim(),
        description: descriptionController.text.trim(),
        acType: acType,
        vehicleType: vehicleTypeText,
        userId: userId,
        createdAt: DateTime.now(),
      );

      await FirebaseFirestore.instance
          .collection('vehicles')
          .add(vehicle.toJson());

      EasyLoading.dismiss();
      EasyLoading.showSuccess('Vehicle saved successfully');
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Failed to save vehicle');
      print('Error saving vehicle: $e');
    }
  }

  Future<void> deleteVehicle(String documentId) async {
    try {
      EasyLoading.show(status: 'Deleting vehicle...');

      await FirebaseFirestore.instance
          .collection('vehicles')
          .doc(documentId)
          .delete();

      EasyLoading.dismiss();
      EasyLoading.showSuccess('Vehicle deleted successfully');
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Failed to delete vehicle');
      print('Error deleting vehicle: $e');
    }
  }

  Future<void> updateVehicle(String documentId) async {
    try {
      EasyLoading.show(status: 'Updating vehicle...');

      String acType = acVehicle.value == 1 ? "AC" : "NonAC";
      String vehicleTypeText = vehicleType.value == 1
          ? "self"
          : vehicleType.value == 2
              ? "passenger"
              : vehicleType.value == 3
                  ? "loader"
                  : "bike";

      await FirebaseFirestore.instance
          .collection('vehicles')
          .doc(documentId)
          .update({
        'name': nameController.text.trim(),
        'number': numberController.text.trim(),
        'contact': contactController.text.trim(),
        'location': locationController.text.trim(),
        'description': descriptionController.text.trim(),
        'acType': acType,
        'vehicleType': vehicleTypeText,
      });

      EasyLoading.dismiss();
      EasyLoading.showSuccess('Vehicle updated successfully');
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Failed to update vehicle');
      print('Error updating vehicle: $e');
    }
  }
}
