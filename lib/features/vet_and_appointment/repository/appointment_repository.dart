import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_friend_hub_app/models/data/appointment_model.dart';
import 'package:pet_friend_hub_app/models/data/vet_clinic_model.dart';

final appointmentRepositoryProvider = Provider((ref) => AppointmentRepository(
      firebaseFirestore: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance,
    ));

class AppointmentRepository {
  FirebaseFirestore firebaseFirestore;
  FirebaseAuth auth;

  AppointmentRepository({
    required this.firebaseFirestore,
    required this.auth,
  });

  Future<List<VetClinic>> getVetClinics() async {
    try {
      List<VetClinic> vetclinics = List<VetClinic>.empty(growable: true);
      var querySnapshot =
          await firebaseFirestore.collection("vetClinics").get();
      for (var doc in querySnapshot.docs) {
        var vetClinic = VetClinic.fromJson(doc.data());
        vetclinics.add(vetClinic);
      }
      return vetclinics;
    } catch (e) {
      throw Exception('ERROR : $e');
    }
  }

  Future<List<Appointment>?> getAppointmentOfUser() async {
    try {
      var userId = auth.currentUser!.uid;
      var snapshot = await firebaseFirestore
          .collection("appointments")
          .where("ownerName", isEqualTo: userId)
          .get();
      var docs = snapshot.docs;
      var appoinemtes = docs.isEmpty
          ? null
          : docs.map((e) => Appointment.fromJson(e.data())).toList();
      return appoinemtes;
    } catch (e) {
      throw Exception('ERROR : $e');
    }
  }

  Future<void> addAppointment(Appointment newAppointment) async {
    try {
      newAppointment.appointmentId =
          _createId(newAppointment.date, newAppointment.time);
      newAppointment.ownerName = auth.currentUser!.uid;
      await firebaseFirestore
          .collection('appointments')
          .doc(newAppointment.appointmentId)
          .set(newAppointment.toJson());
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<void> deleteAppointment(String appointmentId) async {
    try {
      await firebaseFirestore
          .collection('appointments')
          .doc(appointmentId)
          .delete();

      debugPrint('Data ssilindi.');
    } catch (e) {
      throw Exception('Error : $e');
    }
  }

  // New ID
  String _createId(DateTime date, DateTime time) {
    return '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}_${time.hour.toString().padLeft(2, '0')}${time.minute.toString().padLeft(2, '0')}${time.second.toString().padLeft(2, '0')}';
  }
}
