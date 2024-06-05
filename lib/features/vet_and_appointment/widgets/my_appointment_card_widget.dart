import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/constants/color.dart';
import 'package:pet_friend_hub_app/features/vet_and_appointment/controller/appointment_controller.dart';
import 'package:pet_friend_hub_app/models/data/appointment_model.dart';

import '../../../config/items/app_color.dart';
import '../../../widgets/elevated_button_widget.dart';

class MyAppoinmentCardWidget extends StatefulWidget {
  const MyAppoinmentCardWidget({
    super.key,
    required this.appointment,
  });

  final Appointment appointment;

  @override
  State<MyAppoinmentCardWidget> createState() => _MyAppoinmentCardWidgetState();
}

class _MyAppoinmentCardWidgetState extends State<MyAppoinmentCardWidget> {
  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        DateFormat('dd-MM-yyyy').format(widget.appointment.date);
    final String formattedTime =
        DateFormat('HH : mm').format(widget.appointment.time);
    final String clincName = widget.appointment.clinicName ?? 'hata oluştu';

    return Container(
      width: context.width,
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
      child: Card(
        elevation: 5,
        color: Colors.grey.withOpacity(.5),
        child: Padding(
          padding: context.paddingAllLow,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildItem(
                    context,
                    Icons.calendar_month_outlined,
                    formattedDate,
                  ),
                  _buildItem(
                    context,
                    Icons.watch_later_outlined,
                    formattedTime,
                  ),
                  _buildItem(context, Icons.location_on_outlined, clincName),
                ],
              ),
              Column(
                children: [
                  _buildItemBtn(context, 'Görüntüle'),
                  _buildItemBtn(context, 'İptal Et'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemBtn(BuildContext context, String btnTitle) {
    return Consumer(
      builder: (context, ref, child) {
        return SizedBox(
          width: context.dynamicWidth(0.33),
          child: CustomElevatedButton(
            paddingHorizontal: 0,
            paddingVertical: 0,
            btnColor: btnTitle == 'İptal Et' ? Colors.red : AppColor.orange,
            btnTitle: btnTitle,
            titleStyle: context.textTheme.titleSmall
                ?.copyWith(fontSize: 13, color: AppColor.whiteColor),
            onPressed: () {
              btnTitle == 'İptal Et'
                  ? _cancelAppointment(ref)
                  : detailForAppointment;
            },
          ),
        );
      },
    );
  }

  // void cancelAppointment(WidgetRef ref) {
  //   debugPrint('Randevu iptal et: ${widget.appointment.appointmentId}');
  //   ref
  //       .read(appoinntmetnControllerProvider)
  //       .deleteAppointment(widget.appointment.appointmentId!);
  //   setState(() {});
  // }

  Future<void> _cancelAppointment(WidgetRef ref) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: scaffoldBGColor,
          icon: const Icon(
            Icons.warning_amber,
            color: AppColor.whiteColor,
            size: 40,
          ),
          content: const Text('Silmek İstediğinize Emin misiniz!'),
          contentTextStyle: context.textTheme.bodyMedium,
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: <Widget>[
            TextButton(
                child: const Text('Tamam',
                    style: TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  debugPrint(
                      'Randevu iptal et: ${widget.appointment.appointmentId}');
                  ref
                      .read(appoinntmetnControllerProvider)
                      .deleteAppointment(widget.appointment.appointmentId!);
                  setState(() {
                    Navigator.of(context).pop();
                  });
                }),
            TextButton(
                child: const Text(
                  'İptal',
                  style: TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  void detailForAppointment() {
    debugPrint('Randevuyu görüntüle');
  }

  Widget _buildItem(BuildContext context, IconData icon, String? text) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColor.lightBlue,
          size: 30,
        ),
        SizedBox(
          width: context.dynamicWidth(.05),
        ),
        SizedBox(
          width: context.dynamicWidth(.38),
          child: Text(
            text ?? 'Hata oluştu',
            maxLines: 2,
            style: context.textTheme.titleSmall?.copyWith(
              color: AppColor.whiteColor,
              fontSize: 17,
            ),
          ),
        ),
      ],
    );
  }
}
