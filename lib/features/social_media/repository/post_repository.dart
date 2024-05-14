import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/data/post_model.dart';

final postRepositoryPrivder = Provider(
  (ref) => PostRepository(
    firebaseFirestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
    storage: FirebaseStorage.instance,
  ),
);

class PostRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth auth;
  final FirebaseStorage storage;
  PostRepository({
    required this.firebaseFirestore,
    required this.auth,
    required this.storage,
  });

  Future<void> addPostToFirestore(PostModel post, File fileName) async {
    final userToPost = auth.currentUser;
    if (userToPost != null) {
      post.userId = userToPost.uid;
      post.userName = userToPost.displayName;
    }

    debugPrint('girdi');
    // Get the newly created ID
    var documentRef = firebaseFirestore.collection('posts').doc();
    post.postId = documentRef.id;
    post.postImageUrl = await uploadImage(fileName);
    // add data
    documentRef.set(post.toJson());
  }

  Future<List<PostModel>> getPosts() async {
    try {
      List<PostModel> posts = List<PostModel>.empty(growable: true);
      var querySnapshot = await firebaseFirestore.collection("posts").get();
      for (var doc in querySnapshot.docs) {
        var post = PostModel.fromJson(doc.data());
        posts.add(post);
      }
      return posts;
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
