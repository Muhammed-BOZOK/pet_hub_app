class Appointment {
  String? appointmentId;
  String veterinarianId;
  DateTime date;
  DateTime time;
  String petName;
  String? ownerName;
  String? appointmentNot;
  String? clinicName;

  Appointment({
    this.appointmentId,
    required this.veterinarianId,
    required this.date,
    required this.time,
    required this.petName,
    this.ownerName,
    this.appointmentNot,
    this.clinicName,
  });

  // JSON'dan Appointment nesnesi oluşturmak için
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      appointmentId: json['appointmentId'],
      veterinarianId: json['veterinarianId'],
      clinicName: json['clinicName'],
      date: DateTime.parse(json['date']),
      time: DateTime.parse(json['time']),
      petName: json['petName'],
      ownerName: json['ownerName'],
      appointmentNot: json['appointmentNot'],
    );
  }

  // Appointment nesnesini JSON'a dönüştürmek için
  Map<String, dynamic> toJson() {
    return {
      'appointmentId': appointmentId,
      'veterinarianId': veterinarianId,
      'clinicName': clinicName,
      'date': date.toIso8601String(),
      'time': time.toIso8601String(),
      'petName': petName,
      'ownerName': ownerName,
      'appointmentNot': appointmentNot,
    };
  }
}
