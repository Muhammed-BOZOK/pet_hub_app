import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/config/items/app_color.dart';
import 'package:pet_friend_hub_app/models/data/post_model.dart';
import 'package:pet_friend_hub_app/widgets/elevated_button_widget.dart';

import '../controller/posts_controller.dart';

class PostsScreen extends StatelessWidget {
  PostsScreen({
    super.key,
    this.selectedImage,
  });

  final File? selectedImage;
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
              padding: context.paddingAllLow,
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: FileImage(
                            selectedImage!,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: null,
                    cursorColor: AppColor.whiteColor,
                    maxLength: 100,
                    decoration: InputDecoration(
                      fillColor: const Color.fromARGB(255, 44, 41, 41),
                      filled: true,
                      labelText: 'Açıklama Ekle',
                      labelStyle: context.textTheme.titleMedium,
                      counterStyle: const TextStyle(color: Colors.white),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: AppColor.lightBlue,
                      )),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      return CustomElevatedButton(
                        btnTitle: 'Paylaş',
                        onPressed: () {
                          debugPrint('post submit');
                          PostModel newPost = PostModel(
                            description: descriptionController.text == "" ? null : descriptionController.text,
                            timestamp: DateTime.now(),
                          );
                          ref
                              .read(postControllerProvider)
                              .setPostToFirestore(newPost, selectedImage!)
                              .then((value) => Navigator.pop(context));
                        },
                        buttonColor: AppColor.orange,
                      );
                    },
                  )
                ],
              )),
        ));
  }
}
