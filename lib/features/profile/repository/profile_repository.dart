import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/data/pet_model.dart';
import '../../../models/data/post_model.dart';
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

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<UserModel> getUser() async {
    try {
      debugPrint('kullanıcı : ${auth.currentUser!.uid}');
      var userId = auth.currentUser!.uid;
      final docSnapshot =
          await firebaseFirestore.collection("users").doc(userId).get();
      final user = UserModel.fromJson(docSnapshot.data()!);
      user.pets = await getPetsOfUser(userId);
      user.posts = await getPostsOfUser(userId);
      return user;
    } catch (e) {
      throw Exception('Kullanıcı verileri alınamadı: $e');
    }
  }

  Future<List<PostModel>?> getPostsOfUser(String userId) async {
    var snapshot = await firebaseFirestore
        .collection("posts")
        .where("userId", isEqualTo: userId)
        .orderBy("timestamp", descending: true)
        .get();
    var docs = snapshot.docs;
    var posts = docs.isEmpty
        ? null
        : docs.map((e) => PostModel.fromJson(e.data())).toList();
    return posts;
  }

  Future<void> addPetToFirestore(PetModel newPet) async {
    try {
      var docRef = firebaseFirestore.collection('pets').doc();
      newPet.petId = docRef.id;
      newPet.ownerId = auth.currentUser?.uid;
      await docRef.set(newPet.toJson());
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<List<PetModel>?> getPetsOfUser(String userId) async {
    try {
      var snapshot = await firebaseFirestore
          .collection('pets')
          .where("owner_id", isEqualTo: userId)
          .get();
      var docs = snapshot.docs;
      var pets = docs.isEmpty
          ? null
          : docs.map((e) => PetModel.fromJson(e.data())).toList();
      return pets;
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await firebaseFirestore.collection('posts').doc(postId).delete();
      debugPrint('Data ssilindi.');
    } catch (e) {
      throw Exception('Error : $e');
    }
  }
}
