class UserModel {
  String? uid;
  String? userName;
  String? profilePhoto;
  String email;
  String? password;
  String? accountType;
  List<String>? pets;

  UserModel(
      {this.uid,
      this.userName,
      this.profilePhoto,
      required this.email,
      this.password,
      this.accountType,
      this.pets
      });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      userName: json['userName'],
      profilePhoto: json['profilePhoto'],
      email: json['email'],
      password: json['password'],
      accountType: json['accountType'],
      pets: json['pets'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'userName': userName,
      'profilePhoto': profilePhoto,
      'email': email,
      'password': password,
      'accountType': accountType,
      'pets': pets,
    };
  }
}
