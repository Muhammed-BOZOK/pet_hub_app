class UserModel {
  String? uid;
  String? firstName;
  String? lastName;
  String email;
  String password;

  UserModel({
    this.uid,
    this.firstName,
    this.lastName,
    required this.email,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      firstName: json['firsName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['passwword'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'firstNmae': firstName,
      'lastNmae': lastName,
      'email': email,
      'password': password,
    };
  }
}
