import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
      password: userModel.password!,
    );
    if (userInfo.user != null) {
      _storeUserInfoToFirebase(userModel);
    }
  }

  Future<UserModel?> signInWithGoogle() async {
    try {
      //süreci başlat
      final GoogleSignInAccount? gAccount = await GoogleSignIn().signIn();

      //bilgileri al
      final GoogleSignInAuthentication gAuth = await gAccount!.authentication;

      // Kullanıcı Nesnesi Oluştur
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      //kullanıcın girişini sağla
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      debugPrint(user!.displayName);
      debugPrint(user.email);
      final UserModel newUser = UserModel(
        userName: user.displayName,
        email: user.email!,
        profilePhoto: user.photoURL,
      );
      _storeUserInfoToFirebase(newUser);
      return newUser;
    } catch (e) {
      throw Exception('EROR! : $e');
    }
  }

  Future<void> _storeUserInfoToFirebase(UserModel userModel) async {
    try {
      userModel.profilePhoto ??=
          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png";
      userModel.uid = auth.currentUser!.uid;
      userModel.accountType = 'Normal';
      debugPrint(userModel.uid);
      debugPrint(userModel.email);
      await firebaseFirestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .set(userModel.toJson());
    } catch (e) {
      throw Exception('EROR! : $e');
    }
  }
}
