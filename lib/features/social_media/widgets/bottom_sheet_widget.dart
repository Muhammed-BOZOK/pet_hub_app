import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/config/items/app_color.dart';

import '../../../models/data/comment_model.dart';
import '../controller/posts_controller.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({
    super.key,
    required this.postId,
  });

  final String postId;

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  final commentData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Consumer(
      builder: (context, ref, child) {
        return StreamBuilder(
          stream: ref.read(postControllerProvider).getComments(widget.postId),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              List<CommentModel>? comments = snapshot.data;
              return _viewComments(
                mediaQueryData,
                context,
                ref,
                comments!,
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: Text("Error"));
            }
          },
        );
      },
    );
  }

  Padding _viewComments(MediaQueryData mediaQueryData, BuildContext context,
      WidgetRef ref, List<CommentModel>? comments) {
    return Padding(
      padding: mediaQueryData.viewInsets,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: SizedBox(
            height: context.veryhighValue6x,
            child: Column(
              children: [
                Padding(
                  padding: context.paddingVerticalLow,
                  child: Text(
                    'Yorumlar',
                    style: context.textTheme.titleMedium,
                  ),
                ),
                const Divider(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: comments != null ? comments.length : 0,
                    itemBuilder: (context, index) {
                      String url = comments?[index].userPhotoUrl ??
                          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';

                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(url),
                        ),
                        title: Text(
                          '${comments?[index].userName}',
                          style: context.textTheme.titleSmall?.copyWith(
                            color: AppColor.whiteColor,
                          ),
                        ),
                        subtitle: Text(
                          '${comments![index].content}',
                          style: context.textTheme.bodyMedium,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: context.width,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 25,
                        child: Container(
                          height: context.height * 0.06,
                          padding: context.paddingHorizontalLow,
                          decoration: BoxDecoration(
                            color: AppColor.orange,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: TextFormField(
                            controller: commentData,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Yorumunuz...',
                              hintStyle: TextStyle(color: AppColor.whiteColor),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: ElevatedButton(
                            onPressed: () {
                              CommentModel comment = CommentModel(
                                postId: widget.postId,
                                content: commentData.text,
                              );

                              ref
                                  .read(postControllerProvider)
                                  .addCommentToFirestore(comment);
                              FocusScope.of(context).unfocus();
                              setState(() {
                                commentData.clear();
                                comments = null;
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColor.orange),
                            ),
                            child: const Text(
                              'paylaş',
                              style: TextStyle(
                                color: AppColor.whiteColor,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
