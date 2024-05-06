import 'package:flutter/material.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/config/items/app_color.dart';
import 'package:pet_friend_hub_app/features/social_media/controller/posts_controller.dart';
import 'package:pet_friend_hub_app/features/social_media/view/camera_screen.dart';

class SocialMediaScreen extends StatefulWidget {
  const SocialMediaScreen({super.key});

  @override
  State<SocialMediaScreen> createState() => _SocialMediaScreenState();
}

class _SocialMediaScreenState extends State<SocialMediaScreen> {
  double iconSize = 35;
  Color iconColor = AppColor.lightBlue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return _buildItem(context);
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
        title: Text(
          'Sosyal Medya',
          style: context.textTheme.titleLarge,
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _viewShowDialog(context);
            },
            icon: Icon(
              Icons.add_box_outlined,
              color: iconColor,
              size: iconSize * .9,
            ),
          )
        ]);
  }

  Future<dynamic> _viewShowDialog(BuildContext context) {
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
                      await PostsController().pickImageFromGaallery();
                  if (selectedImage != null) {
                    navigator.push(MaterialPageRoute(
                      builder: (context) => PostsScreen(
                        selectedImage: selectedImage,
                      ),
                    ));
                  }
                },
                leading: const Icon(Icons.photo_outlined),
                title: Text(
                  'Fotograf Seç',
                  style: textStyle,
                ),
              ),
              ListTile(
                onTap: () async {
                  debugPrint('Kamera');
                  final navigator = Navigator.of(context);
                  navigator.pop();
                  final selectedImage =
                      await PostsController().pickImageFromCamera();
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
                  'Fotograf Çek',
                  style: textStyle,
                ),
              )
            ],
          );
        });
  }

  SizedBox _buildItem(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: context.veryhighValue6x,
      child: Card(
        color: AppColor.black,
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            Expanded(
              flex: 20,
              child: _itemHeader(context),
            ),
            Expanded(
              flex: 65,
              child: _itemBody(),
            ),
            Expanded(
              flex: 15,
              child: _itemBottom(),
            )
          ],
        ),
      ),
    );
  }

  Row _itemBottom() {
    return Row(
      children: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_border_rounded,
              size: iconSize,
              color: iconColor,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.chat_bubble_outline_rounded,
              size: iconSize,
              color: iconColor,
            ))
      ],
    );
  }

  Widget _itemBody() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/kedi.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _itemHeader(BuildContext context) {
    Color iconColor = AppColor.lightBlue;
    return Padding(
        padding: context.paddingAllLow,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      child: Icon(
                        Icons.person_2_rounded,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                    Padding(
                      padding: context.paddingLeftLow,
                      child: Text(
                        'User Name',
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
                    size: 40,
                    color: iconColor,
                  ),
                ),
              ],
            ),
            const Divider(
              height: 1,
            )
          ],
        ));
  }
}
