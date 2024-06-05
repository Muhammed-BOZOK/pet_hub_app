import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/config/items/app_color.dart';
import 'package:pet_friend_hub_app/features/social_media/controller/post_photo_controller.dart';
import 'package:pet_friend_hub_app/features/social_media/controller/posts_controller.dart';

import '../widgets/bottom_sheet_widget.dart';
import '../widgets/post_item_widget.dart';
import 'add_posts_screen.dart';
import 'package:pet_friend_hub_app/models/data/post_model.dart';

class SocialMediaScreen extends ConsumerWidget {
  SocialMediaScreen({super.key});

  final double iconSize = 35;
  final Color iconColor = AppColor.lightBlue;
  final TextEditingController commentData = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: _buildAppBar(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.orange,
        onPressed: () {
          _selectCameraOrGallery(context);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Icon(
          Icons.add_a_photo_outlined,
          size: iconSize * .9,
          color: AppColor.whiteColor,
        ),
      ),
      body: _buildBody(ref),
    );
  }

  FutureBuilder<List<PostModel>> _buildBody(WidgetRef ref) {
    return FutureBuilder(
        future: ref.read(postControllerProvider).getPost(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final posts = snapshot.data;
            return ListView.builder(
              itemCount: posts?.length,
              itemBuilder: (context, index) {
                return PostItemWidget(
                  post: posts![index],
                  onPressedToAddComment: () {
                    debugPrint('comment : ${posts[index].postId}');
                    _viewBottomSheeet(context, ref, posts[index].postId!);
                  },
                );
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text("Error"));
          }
        });
  }

  Future<dynamic> _viewBottomSheeet(
      BuildContext context, WidgetRef ref, String postId) {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.black,
        context: context,
        builder: (_) {
          return BottomSheetWidget(postId: postId);
        });
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Sosyal Medya',
        style: context.textTheme.titleLarge,
      ),
    );
  }

  Future<dynamic> _selectCameraOrGallery(BuildContext context) {
    final textStyle = context.textTheme.bodyMedium;
    return showModalBottomSheet(
        backgroundColor: Colors.black,
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () async {
                  debugPrint('Galeri');
                  final navigator = Navigator.of(context);
                  navigator.pop();
                  final selectedImage =
                      await PostPhotoController().pickImageFromGaallery();
                  if (selectedImage != null) {
                    navigator.push(MaterialPageRoute(
                      builder: (context) =>
                          PostsScreen(selectedImage: selectedImage),
                    ));
                  }
                },
                leading: const Icon(Icons.photo_outlined),
                title: Text(
                  'Galeri',
                  style: textStyle,
                ),
              ),
              ListTile(
                onTap: () async {
                  debugPrint('Kamera');
                  final navigator = Navigator.of(context);
                  navigator.pop();
                  final selectedImage =
                      await PostPhotoController().pickImageFromCamera();
                  if (selectedImage != null) {
                    navigator.push(MaterialPageRoute(
                      builder: (context) => PostsScreen(
                        selectedImage: selectedImage,
                      ),
                    ));
                  }
                },
                leading: const Icon(Icons.camera_alt_outlined),
                title: Text(
                  'Kamera',
                  style: textStyle,
                ),
              )
            ],
          );
        });
  }
}
