import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_friend_hub_app/models/data/user_model.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    auth: FirebaseAuth.instance,
    firebaseFirestore: FirebaseFirestore.instance,
  ),
);

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firebaseFirestore;

  AuthRepository({
    required this.auth,
    required this.firebaseFirestore,
  });

  /// Kayıt
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUpWithEmailAndPassword(
      {required UserModel userModel}) async {
    final userInfo = await auth.createUserWithEmailAndPassword(
      email: userModel.email,
      password: userModel.password,
    );
    if (userInfo.user != null) {
      storeUserInfoToFirebase(userModel);
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<void> storeUserInfoToFirebase(UserModel userModel) async {
    userModel.uid = auth.currentUser!.uid;
    debugPrint(userModel.uid);
    debugPrint(userModel.email);
    await firebaseFirestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .set(userModel.toJson());
  }
}
