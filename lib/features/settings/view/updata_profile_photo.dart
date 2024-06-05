import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/config/items/app_color.dart';
import 'package:pet_friend_hub_app/features/settings/controller/setting_controller.dart';
import 'package:pet_friend_hub_app/widgets/elevated_button_widget.dart';

class UpdateProfilePhto extends StatelessWidget {
  UpdateProfilePhto({
    super.key,
    this.selectedImage,
  });

  final File? selectedImage;
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
            padding: context.paddingAllLow,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: FileImage(
                      selectedImage!,
                    ),
                  ),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return CustomElevatedButton(
                      btnColor: AppColor.orange,
                      btnTitle: 'Güncelle',
                      onPressed: () {
                        if (selectedImage != null) {
                          debugPrint('photo update ');

                          ref
                              .read(settingControllerProvider)
                              .updateProfilePhoto(selectedImage!);
                          Navigator.pop(context);
                        }
                      },
                    );
                  },
                )
              ],
            )));
  }
}
