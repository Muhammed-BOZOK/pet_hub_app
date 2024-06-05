import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_friend_hub_app/models/data/comment_model.dart';
import 'package:pet_friend_hub_app/models/data/user_model.dart';

import '../../../models/data/post_model.dart';

final postRepositoryProvider = Provider(
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
      var user = await _getUser(userToPost.uid);
      post.userName = user.userName;
      post.userPhotoUrl = user.profilePhoto;
    }

    // Get the newly created ID
    var documentRef = firebaseFirestore.collection('posts').doc();
    post.postId = documentRef.id;
    post.postImageUrl = await uploadImage(fileName);
    // add data
    documentRef.set(post.toJson());
  }

  Future<UserModel> _getUser(String userId) async {
    var data = await firebaseFirestore.collection("users").doc(userId).get();
    var user = UserModel.fromJson(data.data()!);
    return user;
  }

  Future<List<PostModel>> getPosts() async {
    try {
      List<PostModel> posts = List<PostModel>.empty(growable: true);
      var querySnapshot = await firebaseFirestore
          .collection("posts")
          .orderBy("timestamp", descending: true)
          .get();
      for (var doc in querySnapshot.docs) {
        var post = PostModel.fromJson(doc.data());
        post.numberOfComment = await _getnumberOfComment(post.postId);
        posts.add(post);
      }
      return posts;
    } catch (e) {
      throw Exception('Error : $e');
    }
  }

  Future<int?> _getnumberOfComment(String? postId) async {
    var snapshot = await firebaseFirestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .get();
    var list = snapshot.docs.map((doc) => doc.data()).toList();
    var number = list.length;
    return number;
  }

  Future<void> addCommentToFirestore(CommentModel newComment) async {
    var userId = auth.currentUser!.uid;
    var user = await _getUser(userId);
    newComment.userId = userId;
    newComment.userPhotoUrl = user.profilePhoto;
    newComment.userName = user.userName;

    var docRef = firebaseFirestore
        .collection('posts')
        .doc(newComment.postId)
        .collection('comments')
        .doc();
    newComment.commentId = docRef.id;
    docRef.set(newComment.toJson());

    /// !!! Gerekli olabilir....
    // await firebaseFirestore
    //       .collection('posts')
    //       .doc(newComment.postId)
    //       .update({
    //     'comment': FieldValue.arrayUnion([newComment.toJson()])
    //   });
  }

  Future<List<CommentModel>> getCommentF(String postId) async {
    List<CommentModel> comments = List<CommentModel>.empty(growable: true);

    var querySnapshot = await firebaseFirestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .get();

    for (var doc in querySnapshot.docs) {
      var post = CommentModel.fromJson(doc.data());
      comments.add(post);
    }
    return comments;
  }

  Stream<List<CommentModel>> getComments(String postId) {
    try {
      List<CommentModel> comments = List<CommentModel>.empty(growable: true);
      var data = firebaseFirestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .snapshots()
          .map((event) {
        for (var doc in event.docs) {
          var comment = CommentModel.fromJson(doc.data());
          comments.add(comment);
        }
        return comments;
      });

      return data;
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
