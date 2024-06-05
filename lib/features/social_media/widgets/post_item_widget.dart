import 'package:flutter/material.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';

import '../../../config/items/app_color.dart';
import '../../../models/data/post_model.dart';

class PostItemWidget extends StatefulWidget {
  const PostItemWidget({
    super.key,
    required this.post,
    this.onPressedToAddComment,
    this.onPressedToLike,
  });

  final PostModel post;
  final Function()? onPressedToAddComment;
  final Function()? onPressedToLike;

  @override
  State<PostItemWidget> createState() => _PostItemWidgetState();
}

class _PostItemWidgetState extends State<PostItemWidget> {
  final double iconSize = 30;

  final Color iconColor = AppColor.lightBlue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Card(
        color: AppColor.black,
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(children: [
          _itemHeader(context),
          if (widget.post.description != null) _itemDescription(context),
          _itemBody(context),
          _itemBottom(),
        ]),
      ),
    );
  }

  Widget _itemBottom() {
    return Row(
      children: [
        IconButton(
            onPressed: widget.onPressedToLike,
            icon: Icon(
              Icons.favorite_border_rounded,
              size: iconSize,
              color: iconColor,
            )),
        IconButton(
            onPressed: widget.onPressedToAddComment,
            icon: Icon(
              widget.post.numberOfComment == 0
                  ? Icons.chat_bubble_outline_rounded
                  : Icons.chat_outlined,
              size: iconSize,
              color: iconColor,
            )),
        Text(
          widget.post.numberOfComment != 0
              ? '${widget.post.numberOfComment}'
              : '',
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Padding _itemDescription(BuildContext context) {
    debugPrint('${widget.post.description}');
    return Padding(
      padding: context.paddingHorizontalLow,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '${widget.post.description}',
          maxLines: 3,
          style: context.textTheme.bodyMedium,
        ),
      ),
    );
  }

  Widget _itemBody(BuildContext context) {
    return Padding(
      padding: context.paddingVerticalDefault,
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.post.postImageUrl!),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemHeader(BuildContext context) {
    Color iconColor = AppColor.lightBlue;
    String? profilePhotoUrl = widget.post.userPhotoUrl;
    return Padding(
      padding: context.paddingAllLow,
      child: SizedBox(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    profilePhotoUrl == null ? const CircleAvatar(
                      child: Icon(
                        Icons.person_2_rounded,
                        color: Colors.black,
                        size: 40,
                      ),
                    ) 
                    : CircleAvatar(
                      backgroundImage: NetworkImage(profilePhotoUrl),
                    ),
                    Padding(
                      padding: context.paddingLeftLow,
                      child: Text(
                        widget.post.userName ?? 'User Name',
                        style: context.textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert_rounded,
                    size: 35,
                    color: iconColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              height: 0.1,
              color: AppColor.orange,
            )
          ],
        ),
      ),
    );
  }
}
