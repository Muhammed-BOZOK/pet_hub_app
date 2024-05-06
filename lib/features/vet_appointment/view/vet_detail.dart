import 'package:flutter/material.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/config/items/app_color.dart';
import 'package:pet_friend_hub_app/widgets/elevated_button_widget.dart';

import '../widget/calender_item_widget.dart';

class VetDetail extends StatelessWidget {
  const VetDetail({super.key});
  final String _appBarTitle = 'Randevu Al';
  final String _about =
      "Dr. Chariyeva Leyla en iyi Nanyang Hospotalat'ta kardiyolog uzmanı Londra'da mevcutturveya özel Danışma.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_appBarTitle, style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(
          color: AppColor.whiteColor,
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: context.paddingAllDefault,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 25,
              child: SizedBox(
                width: context.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: context.dynamicWidth(0.13),
                    ),
                    Text(
                      'Muhammed Bozok',
                      style: context.textTheme.titleLarge,
                    ),
                  ],
                ),
              )),
          const Spacer(flex: 2,),
          Expanded(flex: 6, child: _buildTitle(context, 'Hakkında')),
          Expanded(
            flex: 25,
            child: Text(
              _about,
              style: context.textTheme.bodyLarge
                  ?.copyWith(color: AppColor.lightBlue),
              maxLines: 4,
            ),
          ),
          const Spacer(flex: 1,),
          Expanded(flex: 6, child: _buildTitle(context, 'Takvim')),
          Expanded(
            flex: 15,
            child: _viewCalender(),
          ),
          const Spacer(flex: 1,),

          Expanded(
            flex: 6,
            child: _buildTitle(context, 'Saat'),
          ),
          Expanded(
            flex: 30,
            child: Wrap(
              children: [
                _buildClockItem(context, '09.00'),
                _buildClockItem(context, '09.00'),
                _buildClockItem(context, '09.00'),
                _buildClockItem(context, '09.00'),
                _buildClockItem(context, '09.00'),
                _buildClockItem(context, '09.00'),
                _buildClockItem(context, '09.00'),
                _buildClockItem(context, '09.00'),
                _buildClockItem(context, '17.00'),
              ],
            ),
          ),
          Expanded(
            flex: 10,
            child: SizedBox(
              width: context.width,
              child: CustomElevatedButton(
                text: 'Randeü Al',
                borderRadius: 15  ,
                buttonColor: AppColor.orange,
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView _viewCalender() {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CalenderItemWidget(
            tarih: '29',
            day: 'Pzt.',
          ),
          CalenderItemWidget(
            tarih: '28',
            day: 'Sal.',
          ),
          CalenderItemWidget(
            tarih: '30',
            day: 'Çar.',
          ),
          CalenderItemWidget(
            tarih: '30',
            day: 'Per.',
          ),
          CalenderItemWidget(
            tarih: '30',
            day: 'Cum.',
          ),
          CalenderItemWidget(
            tarih: '30',
            day: 'Cmt.',
          ),
          CalenderItemWidget(
            tarih: '30',
            day: 'Pzr.',
          ),
        ],
      ),
    );
  }

  GestureDetector _buildClockItem(BuildContext context, String label) {
    return GestureDetector(
      child: Card(
        color: AppColor.orange,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.dynamicWidth(.05),
              vertical: context.dynamicWidth(.02)),
          child: Text(
            label,
            style: context.textTheme.labelLarge,
          ),
        ),
      ),
    );
  }

  Text _buildTitle(BuildContext context, String title) {
    return Text(
      title,
      style: context.textTheme.headlineSmall,
    );
  }
}
