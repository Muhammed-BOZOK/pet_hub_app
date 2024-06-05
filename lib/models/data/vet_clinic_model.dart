class VetClinic {
  String? vetClinicId;
  String clinicName;
  String addres;
  String phone;
  String? clinicLogo;
  String? about;

  VetClinic({
    this.vetClinicId,
    required this.clinicName,
    required this.addres,
    required this.phone,
    this.clinicLogo,
    this.about,
  });

  // fromJson metodu
  factory VetClinic.fromJson(Map<String, dynamic> json) {
    return VetClinic(
      vetClinicId: json['vetClinicId'],
      clinicName: json['clinicName'],
      addres: json['addres'],
      phone: json['phone'],
      clinicLogo: json['clinicLogo'],
      about: json['about'],
    );
  }

  // toJson metodu
  Map<String, dynamic> toJson() {
    return {
      'vetClinicId': vetClinicId,
      'clinicName': clinicName,
      'addres': addres,
      'phone': phone,
      'clinicLogo': clinicLogo,
      'about': about,
    };
  }
}
