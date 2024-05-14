import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/data/user_model.dart';

final prfileRepositoryProvider = Provider((ref) => ProfileRepository(
      firebaseFirestore: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance,
    ));

class ProfileRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth auth;

  ProfileRepository({
    required this.firebaseFirestore,
    required this.auth,
  });

  Future<UserModel> getUser() async {
    try {
      debugPrint('kullanıcı : ${auth.currentUser!.uid}');
      final user = await firebaseFirestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .get();
      final duser = UserModel.fromJson(user.data()!);
      debugPrint(duser.profilePhoto);
      return duser;
    } catch (e) {
      throw Exception('Kullanıcı verileri alınamadı: $e');
    }
  }
}
