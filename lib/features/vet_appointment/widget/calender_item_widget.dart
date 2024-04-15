import 'package:flutter/material.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/config/items/app_color.dart';

class CalenderItemWidget extends StatefulWidget {
  const CalenderItemWidget({
    super.key,
    this.tarih = '1',
    this.day = 'day',
  });

  final String? tarih;
  final String? day;

  @override
  State<CalenderItemWidget> createState() => _CalenderItemWidgetState();
}

class _CalenderItemWidgetState extends State<CalenderItemWidget> {
  bool isActive = false;
  String? data;
  @override
  Widget build(BuildContext context) {
    var textStyle1 = context.textTheme.titleMedium;
    return SizedBox(
      width: context.dynamicWidth(0.22),
      child: GestureDetector(
        onTap: () {
          if (data == null) {
            isActive = !isActive;
          }
          debugPrint('akitf : $isActive');
          debugPrint(data);
          debugPrint(widget.tarih! + widget.day!);
          setState(() {});
        },
        child: Card(
          elevation: 5,
          color: isActive == true ? AppColor.blacColor : AppColor.orange,
          child: Center(
            child: Text(
              '${widget.tarih!}\n ${widget.day!}',
              style: textStyle1?.copyWith(
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
