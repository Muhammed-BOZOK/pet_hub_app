import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/config/items/app_color.dart';
import 'package:pet_friend_hub_app/features/vet_appointment/view/vet_detail.dart';

class VetAppointmentScreen extends StatelessWidget {
  const VetAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Klinik Seçimi',
          style: context.textTheme.titleLarge,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.filter_list_rounded,
                color: AppColor.lightBlue,
                size: 30,
              ))
        ],
      ),
      body: Padding(
        padding: context.paddingHorizontalDefault,
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: context.paddingBottomLow,
              child: const VetItemCardWidget(),
            );
          },
        ),
      ),
    );
  }
}

class VetItemCardWidget extends StatelessWidget {
  const VetItemCardWidget({
    super.key,
    this.itemTitle = 'Kılinik Adı muhammed bozok',
    this.btnTitle = 'Randevu Al',
  });

  final String? btnTitle;
  final String? itemTitle;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: Container(
        height: context.veryhighValue2x,
        width: context.width,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.blue),
        ),
        child: Padding(
          padding: context.paddingAllDefault,
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: _itemImage(context),
              ),
              Expanded(
                flex: 6,
                child: _buildItemRightBox(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column _buildItemRightBox(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          itemTitle!,
          maxLines: 2,
          style: context.textTheme.titleLarge,
        ),
        ElevatedButton(
            onPressed: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: const VetDetail(),
                withNavBar: false,
              );
            },
            child: Text(btnTitle!))
      ],
    );
  }

  Container _itemImage(BuildContext context) {
    return Container(
      margin: context.paddingRightLow,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
