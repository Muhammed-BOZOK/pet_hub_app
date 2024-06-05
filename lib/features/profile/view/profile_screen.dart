import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/config/items/app_color.dart';
import 'package:pet_friend_hub_app/config/routes/route_name.dart';
import 'package:pet_friend_hub_app/features/profile/controller/profile_controller.dart';
import 'package:pet_friend_hub_app/models/data/pet_model.dart';
import 'package:pet_friend_hub_app/models/data/user_model.dart';

import '../../../models/data/post_model.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  final double headIconSize = 30;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: FutureBuilder(
        future: ref.read(profileControllerProvider).getuser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final activeUser = snapshot.data;
            return _buildBody(context, activeUser!);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text("Error"));
          }
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, UserModel user) {
    return SizedBox(
      height: context.height,
      child: Column(
        children: [
          Expanded(
            flex: 38,
            child: _buildHeader(context, user),
          ),
          Expanded(
            flex: 65,
            child: _buildConten(context, user),
          )
        ],
      ),
    );
  }

  Widget _buildConten(BuildContext context, UserModel user) {
    var posts = user.posts;
    var pets = user.pets;
    return SingleChildScrollView(
      padding: context.paddingHorizontalDefault,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTitle(context, 'Evcll Hayvanlarım'),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouteNames.addPet);
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 25,
                    color: AppColor.whiteColor,
                  ))
            ],
          ),
          pets != null
              ? _viewPetOfUser(context, pets)
              : _emptyView(
                  context,
                  'Henüz Evcil Hayvan Eklemediniz!.',
                ),
          _buildTitle(context, 'Fotograf Albümü'),
          posts != null
              ? _viewPostOfUser(posts, user.profilePhoto!)
              : _emptyView(
                  context,
                  'Henüz Gönderiniz Yok!',
                )
        ],
      ),
    );
  }

  Widget _viewPetOfUser(BuildContext context, List<PetModel> pets) {
    return SizedBox(
      height: context.dynamicHeight(.2),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: pets.length,
        itemBuilder: (context, index) {
          return _buildPetItem(context, pets[index]);
        },
      ),
    );
  }

  Widget _viewPostOfUser(List<PostModel> posts, String userProfilPhoto) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 5.0, // Dikey aralıklar
        crossAxisSpacing: 5.0,
        mainAxisExtent: 150,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRouteNames.detailPost,
              arguments: {
                'userProfilPhoto': userProfilPhoto,
                'post': posts[index],
              },
            );
          },
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: Container(
              height: context.dynamicHeight(0.05),
              width: 25,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.1),
                image: DecorationImage(
                  image: NetworkImage(posts[index].postImageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
              // child: Image.network(posts[index].postImageUrl!)
            ),
          ),
        );
      },
    );
  }

  Widget _buildPetItem(BuildContext context, PetModel pet) {
    double boxSize = context.dynamicHeight(.17);

    return SizedBox(
      width: boxSize,
      child: Card(
        color: AppColor.orange.withOpacity(0.5),
        child: Padding(
          padding: context.paddingAllLow,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const CircleAvatar(
                radius: 25,
              ),
              Text(
                pet.name ?? 'Error',
                style: context.textTheme.titleSmall
                    ?.copyWith(color: AppColor.whiteColor),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, UserModel user) {
    return Container(
      padding: context.paddingAllLow,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
          border: Border(
              bottom: BorderSide(
            color: AppColor.orange,
            width: 1,
          ))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _buildIconBtn(Icons.settings, () {
                    debugPrint('ayarlar');
                    Navigator.pushNamed(context, AppRouteNames.settings);
                  }),
                  _buildIconBtn(
                    Icons.notifications_none,
                    () {
                      debugPrint('bildirim');
                    },
                  )
                ],
              ),
              Consumer(
                builder: (context, ref, child) {
                  return _buildIconBtn(
                    Icons.logout_rounded,
                    () {
                      debugPrint('Çıkış');
                      ref
                          .read(profileControllerProvider)
                          .signOut()
                          .whenComplete(() => Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRouteNames.signIn,
                              (route) => false));
                    },
                  );
                },
              )
            ],
          ),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(user.profilePhoto!),
          ),
          SizedBox(
            height: context.dynamicHeight(0.03),
          ),
          Column(
            children: [
              _viewText(
                Alignment.center,
                user.userName!,
                context.textTheme.titleLarge,
              ),
              _viewText(
                Alignment.center,
                'Hesap Türü: Kullanıcı',
                context.textTheme.titleSmall,
              ),
            ],
          )
        ],
      ),
    );
  }

  IconButton _buildIconBtn(IconData icon, VoidCallback onTap) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        icon,
        color: AppColor.whiteColor,
        size: headIconSize,
      ),
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Text(
          title,
          style: context.textTheme.headlineSmall,
        ),
      ),
    );
  }

  Align _viewText(
      AlignmentGeometry alignmentGeometry, String text, var textStyle) {
    return Align(
      alignment: alignmentGeometry,
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }

  Widget _emptyView(BuildContext context, String text) {
    return Center(
      child: Text(
        text,
        style: context.textTheme.bodyMedium,
      ),
    );
  }
}
