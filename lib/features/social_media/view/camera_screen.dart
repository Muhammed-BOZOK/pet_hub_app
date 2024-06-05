import 'dart:io';

import 'package:flutter/material.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({
    super.key,
    this.selectedImage,
  });

  final File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: AspectRatio(
          aspectRatio: 1 / 1,
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
        ));
  }
}
