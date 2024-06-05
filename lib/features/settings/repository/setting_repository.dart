import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingRepositoryProvider = Provider(
  (ref) => SettingRepository(
    firebaseFirestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
    storage: FirebaseStorage.instance,
  ),
);

class SettingRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth auth;
  final FirebaseStorage storage;
  SettingRepository({
    required this.firebaseFirestore,
    required this.auth,
    required this.storage,
  });

  Future<void> updateProfilePhoto(File newPhoto) async {
    try {
      var userId = auth.currentUser!.uid;
      String photoUrl = await uploadImage(newPhoto);
      await firebaseFirestore.collection('users').doc(userId).update({'profilePhoto': photoUrl});
    } catch (e) {
      throw Exception('Error : $e');
    }
  }

  Future<String> uploadImage(File fileName) async {
    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    var taskSnapshot =
        await storage.ref().child('post_images/$imageName').putFile(fileName);
    var url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }
}
