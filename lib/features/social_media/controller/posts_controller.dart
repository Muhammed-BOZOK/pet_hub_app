import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PostsController {
  Future<dynamic> pickImageFromGaallery() async {
    final imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imageFile == null) return null;
    final cropedImage = _imageCrop(File(imageFile.path));
    return cropedImage;
  }

  Future<dynamic> pickImageFromCamera() async {
    final imageFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (imageFile == null) return;
    return File(imageFile.path);
  }

  Future<File?> _imageCrop(File imageFile) async {
    final CroppedFile? cropedImage = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 9));
    if (cropedImage == null) return null;
    return File(cropedImage.path);
  }
}
