import 'pet_model.dart';
import 'post_model.dart';

class UserModel {
  String? uid;
  String? userName;
  String? profilePhoto;
  String email;
  String? password;
  String? accountType;
  List<PetModel>? pets;
  List<PostModel>? posts;

  UserModel({
    this.uid,
    this.userName,
    this.profilePhoto,
    required this.email,
    this.password,
    this.accountType,
    this.pets,
    this.posts,
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
