import 'package:flutter/material.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/config/items/app_color.dart';
import 'package:pet_friend_hub_app/features/settings/view/updata_profile_photo.dart';

import '../../social_media/controller/post_photo_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  final String _appBarTitle = 'Aayarlar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _appBarTitle,
          style: context.textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: context.paddingAllDefault,
        child: Column(
          children: [
            _buildTitle(
              context,
              'Profili fotografı güncelle',
              () {
                _selectCameraOrGallery(context);
              },
            ),
            _buildTitle(
              context,
              'Profili Düzenle',
              () {},
            ),
            _buildTitleAndSubtitle(context, 'Bölge', 'Türkiye'),
            _buildTitle(
              context,
              'Hakkında',
              () {},
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context, String title, Function() onTap) {
    return Card(
      color: AppColor.orange,
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: context.textTheme.headlineSmall,
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        iconColor: AppColor.whiteColor,
      ),
    );
  }

  Widget _buildTitleAndSubtitle(
      BuildContext context, String title, String subTitle) {
    return Card(
      color: AppColor.orange,
      child: ListTile(
        title: Text(
          title,
          style: context.textTheme.headlineSmall,
        ),
        subtitle: Text(
          subTitle,
          style: context.textTheme.titleSmall,
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        iconColor: AppColor.whiteColor,
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
                          UpdateProfilePhto(selectedImage: selectedImage),
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
                      builder: (context) => UpdateProfilePhto(
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
