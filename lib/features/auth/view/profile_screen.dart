import 'package:flutter/material.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/config/items/app_color.dart';
import 'package:pet_friend_hub_app/config/routes/route_name.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final double headIconSize = 30;

  final List<String> photo = [
    'assets/images/kedi.jpg',
    'assets/images/kedi.jpg',
    'assets/images/kedi.jpg',
    'assets/images/kedi.jpg',
    'assets/images/dog.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SizedBox(
      height: context.height,
      child: Padding(
        padding: context.paddingHorizontalDefault,
        child: Column(
          children: [
            Expanded(
              flex: 25,
              child: _buildHeader(context),
            ),
            Expanded(
              flex: 75,
              child: _buildConten(context),
            )
          ],
        ),
      ),
    );
  }

  SingleChildScrollView _buildConten(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildTitle(context, 'Evcll Hayvanlarım'),
          Wrap(
            children: [
              _buildPetItem(context, 'Dog'),
              _buildPetItem(context, 'Cat'),
            ],
          ),
          _buildTitle(context, 'Fotograf Albümü'),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8.0, // Dikey aralıklar
              crossAxisSpacing: 8.0,
              mainAxisExtent: 150,
            ),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                color: Colors.white,
                height: 50,
                width: 25,
                child: Image.asset(
                  photo[index],
                  fit: BoxFit.cover,
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildPetItem(BuildContext context, String itemTitle) {
    double boxSize = context.dynamicHeight(0.17);
    return SizedBox(
      height: boxSize,
      width: boxSize * 0.75,
      child: Card(
        color: AppColor.orange.withOpacity(0.5),
        child: Padding(
          padding: context.paddingAllLow,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const CircleAvatar(
                radius: 30,
              ),
              Text(
                itemTitle,
                style: context.textTheme.titleMedium,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: context.paddingVerticalLow,
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
              _buildIconBtn(
                Icons.logout_rounded,
                () {
                  debugPrint('Çıkış');
                },
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                flex: 3,
                child: CircleAvatar(
                  radius: 40,
                  child: Icon(Icons.person_2_rounded),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 9,
                child: Column(
                  children: [
                    _viewText(Alignment.topLeft, 'Muhammed Bozok',
                        context.textTheme.titleLarge),
                    _viewText(Alignment.centerRight, 'Hesap Türü: Nromal',
                        context.textTheme.titleSmall),
                  ],
                ),
              )
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
}
