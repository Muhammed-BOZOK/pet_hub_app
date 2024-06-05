import 'package:flutter/material.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/config/items/app_color.dart';
import 'package:pet_friend_hub_app/config/routes/route_name.dart';
import 'package:pet_friend_hub_app/models/data/vet_clinic_model.dart';
import 'package:pet_friend_hub_app/widgets/elevated_button_widget.dart';

class VetItemCardWidget extends StatelessWidget {
  const VetItemCardWidget({
    super.key,
    required this.vetClinic,
  });

  final VetClinic vetClinic;
  final String btnTitle = 'Görüntüle';

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: Container(
        width: context.width,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.blue),
        ),
        child: Padding(
          padding: context.paddingAllLow,
          child: Row(
            children: [
              Expanded(flex: 30, child: _itemImage(context)),
              Expanded(flex: 65, child: _buildItemRightBox(context)),
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
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            vetClinic.clinicName,
            maxLines: 2,
            style: context.textTheme.titleMedium?.copyWith(
              fontSize: 20,
            ),
          ),
        ),
        Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: AppColor.lightBlue,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: context.dynamicWidth(.5),
                child: Text(
                  vetClinic.addres,
                  maxLines: 3,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontSize: 12,
                    color: AppColor.whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: context.dynamicWidth(.45),
          child: CustomElevatedButton(
            paddingHorizontal: 0,
            borderRadius: 25,
            btnColor: AppColor.orange,
            btnTitle: btnTitle,
            titleStyle: context.textTheme.titleMedium?.copyWith(
              fontSize: 18,
            ),
            onPressed: () {
              Navigator.pushNamed(context, AppRouteNames.vetDetail, arguments: {
                'vetClinic': vetClinic,
              });
            },
          ),
        )
      ],
    );
  }

  Container _itemImage(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      margin: context.paddingRightLow,
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage(vetClinic.clinicLogo!),
          )),
    );
  }
}
