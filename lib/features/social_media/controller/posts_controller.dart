import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/data/post_model.dart';
import '../repository/post_repository.dart';

final postControllerProvider = Provider(
  (ref) => PostsController(postRepository: ref.watch(postRepositoryPrivder)),
);

class PostsController {
  final PostRepository postRepository;

  PostsController({
    required this.postRepository,
  });

  Future<void> setPostToFirestore(PostModel post, File fileName) async {
    return postRepository.addPostToFirestore(post,fileName);
  }

  Future<List<PostModel>> getPost() async {
    return postRepository.getPosts();
  }
}
