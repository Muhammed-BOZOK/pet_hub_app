import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/data/comment_model.dart';
import '../../../models/data/post_model.dart';
import '../repository/post_repository.dart';

final postControllerProvider = Provider(
  (ref) => PostsController(postRepository: ref.watch(postRepositoryProvider)),
);

class PostsController {
  final PostRepository postRepository;

  PostsController({
    required this.postRepository,
  });

  Future<void> setPostToFirestore(PostModel post, File fileName) async {
    return postRepository.addPostToFirestore(post, fileName);
  }

  Future<List<PostModel>> getPost() async {
    return postRepository.getPosts();
  }

  Future<void> addCommentToFirestore(CommentModel newComment) {
    return postRepository.addCommentToFirestore(newComment);
  }

  Stream<List<CommentModel>> getComments(String postId) {
    return postRepository.getComments(postId);
  }

  Future<List<CommentModel>> getCommentF(String postId) {
    return postRepository.getCommentF(postId);
  }
}
