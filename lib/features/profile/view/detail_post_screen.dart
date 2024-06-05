import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/features/profile/controller/profile_controller.dart';
import 'package:pet_friend_hub_app/models/data/post_model.dart';

import '../../../config/items/app_color.dart';

class DetailPostScreen extends StatelessWidget {
  const DetailPostScreen({
    super.key,
    required this.post,
    required this.userProfilePhoto,
  });

  final PostModel post;
  final String userProfilePhoto;

  final Color iconColor = AppColor.lightBlue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: context.paddingVerticalLow,
        child: Column(children: [
          _itemHeader(context),
          if (post.description != null) _itemDescription(context),
          _itemBody(context),
          _itemBottom(),
          const SizedBox(
            height: 5,
          )
        ]),
      ),
    );
  }

  Widget _itemBottom() {
    return Row(
      children: [
        const SizedBox(
          width: 5,
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_border_rounded,
              size: 35,
              color: iconColor,
            )),
        const SizedBox(
          width: 5,
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.chat_bubble_outline_rounded,
              size: 35,
              color: iconColor,
            ))
      ],
    );
  }

  Padding _itemDescription(BuildContext context) {
    debugPrint('${post.description}');
    return Padding(
      padding: context.paddingHorizontalLow,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '${post.description}',
          maxLines: 3,
          style: context.textTheme.bodyMedium,
        ),
      ),
    );
  }

  Widget _itemBody(BuildContext context) {
    return Padding(
      padding: context.paddingAllLow,
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(post.postImageUrl!),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemHeader(BuildContext context) {
    Color iconColor = Colors.blue;
    return Padding(
      padding: context.paddingAllLow,
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(userProfilePhoto),
                    ),
                    Padding(
                      padding: context.paddingLeftLow,
                      child: Text(
                        post.userName ?? 'User Name',
                        style: context.textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    _options(context);
                  },
                  icon: Icon(
                    Icons.more_vert_rounded,
                    size: 35,
                    color: iconColor,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _options(BuildContext context) {
    final textStyle = context.textTheme.bodyMedium;
    return showModalBottomSheet(
        backgroundColor: Colors.black,
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer(
                builder: (context, ref, child) {
                  return ListTile(
                    onTap: () async {
                      ref
                          .read(profileControllerProvider)
                          .deletePost(post.postId!)
                          .then((_) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
                    },
                    leading: const Icon(Icons.photo_outlined),
                    title: Text(
                      'Gönderiyi Sil',
                      style: textStyle,
                    ),
                  );
                },
              )
            ],
          );
        });
  }
}
