import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/data/appointment_model.dart';
import '../../../models/data/vet_clinic_model.dart';
import '../repository/appointment_repository.dart';

final appoinntmetnControllerProvider = Provider((ref) => AppointmetnController(
      appointmentRepository: ref.watch(appointmentRepositoryProvider),
    ));

class AppointmetnController {
  AppointmentRepository appointmentRepository;

  AppointmetnController({
    required this.appointmentRepository,
  });

  Future<List<VetClinic>> getVetClinics() async {
    return await appointmentRepository.getVetClinics();
  }

  Future<List<Appointment>?> getAppointmentOfUser() async {
    return await appointmentRepository.getAppointmentOfUser();
  }

  Future<void> addAppointment(Appointment newAppointment) async {
    return await appointmentRepository.addAppointment(newAppointment);
  }

  Future<void> deleteAppointment(String appointmentId) async {
    return await appointmentRepository.deleteAppointment(appointmentId);
  }
}
