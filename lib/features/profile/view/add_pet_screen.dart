import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/config/items/app_color.dart';
import 'package:pet_friend_hub_app/features/profile/controller/profile_controller.dart';
import 'package:pet_friend_hub_app/models/data/pet_model.dart';

import '../../../widgets/elevated_button_widget.dart';
import '../widgets/textfield_widget.dart';

class AddPetScreen extends StatelessWidget {
  AddPetScreen({super.key});

  // late DateTime? selectedDate;
  final TextEditingController petNameData = TextEditingController();
  final TextEditingController petWeightDta = TextEditingController();
  final TextEditingController petGenderData = TextEditingController();
  final TextEditingController petBreedData = TextEditingController();
  final TextEditingController petAboutdData = TextEditingController();
  final pickedImage = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.paddingAllDefault,
          child: Column(
            children: [
              //_buildAspectRatio(context),
              _buildCircleAvatar(),
              SizedBox(
                height: context.dynamicHeight(.03),
              ),

              CustomTextFieldWidget(
                controller: petNameData,
                hintText: 'Adı',
              ),
              SizedBox(
                height: context.dynamicHeight(.03),
              ),
              CustomTextFieldWidget(
                controller: petWeightDta,
                hintText: 'Kilosu',
              ),
              SizedBox(
                height: context.dynamicHeight(.03),
              ),
              CustomTextFieldWidget(
                controller: petGenderData,
                hintText: 'Cinsiyeti',
              ),
              SizedBox(
                height: context.dynamicHeight(.03),
              ),
              CustomTextFieldWidget(
                controller: petBreedData,
                hintText: 'Cinsi',
              ),
              SizedBox(
                height: context.dynamicHeight(.03),
              ),
              CustomTextFieldWidget(
                controller: petAboutdData,
                hintText: 'Hakkında',
              ),
              SizedBox(
                height: context.dynamicHeight(.03),
              ),
              // CustomTextFieldWidget(
              //   controller: descriptionController,
              //   hintText: 'Doğum Tarihi',
              // ),
              SizedBox(
                height: context.dynamicHeight(.03),
              ),
              Consumer(
                builder: (context, ref, child) {
                  return CustomElevatedButton(
                    btnColor: AppColor.orange,
                    textColor: AppColor.whiteColor,
                    borderRadius: 25,
                    btnTitle: 'Ekle',
                    onPressed: () async {
                      if (petNameData.text.isEmpty ||
                          petWeightDta.text.isEmpty ||
                          petGenderData.text.isEmpty ||
                          petAboutdData.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Lütfen tüm alanları doldurun")));
                      } else {
                        debugPrint('event submit');
                        PetModel newPet = PetModel(
                          name: petNameData.text,
                          weight: petWeightDta.text,
                          gender: petGenderData.text,
                          breed: petBreedData.text,
                          about: petAboutdData.text,
                        );
                        ref
                            .read(profileControllerProvider)
                            .addPetToFirestore(newPet);
                        Navigator.pop(context);
                      }
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  CircleAvatar _buildCircleAvatar() {
    return CircleAvatar(
      backgroundColor: AppColor.lightBlue,
      radius: 60,
      child: pickedImage != null
          ? Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(
                    pickedImage!,
                  ),
                ),
              ),
            )
          : IconButton(
              icon: const Icon(
                Icons.add_a_photo_rounded,
                size: 30,
              ),
              onPressed: () {
                //modalBottomSheetBuilderForPopUpMenu(context);
              },
            ),
    );
  }

  // AspectRatio _buildAspectRatio(BuildContext context) {
  //   return AspectRatio(
  //     aspectRatio: 16 / 10,
  //     child: pickedImage != null
  //         ? Container(
  //             decoration: BoxDecoration(
  //               image: DecorationImage(
  //                 image: FileImage(
  //                   pickedImage!,
  //                 ),
  //               ),
  //             ),
  //           )
  //         : Container(
  //             color: Colors.grey,
  //             child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   IconButton(
  //                     icon: const Icon(
  //                       Icons.camera_alt_outlined,
  //                       size: 50,
  //                     ),
  //                     onPressed: () {
  //                       modalBottomSheetBuilderForPopUpMenu(context);
  //                     },
  //                   ),
  //                   const Text(
  //                     "Bir fotoğraf ekle",
  //                     style: TextStyle(color: Colors.white, fontSize: 15),
  //                   )
  //                 ]),
  //           ),
  //   );
  // }
}
