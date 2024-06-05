import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/config/items/app_color.dart';
import 'package:pet_friend_hub_app/features/vet_and_appointment/controller/appointment_controller.dart';
import 'package:pet_friend_hub_app/models/data/appointment_model.dart';
import 'package:pet_friend_hub_app/models/data/vet_clinic_model.dart';
import 'package:pet_friend_hub_app/widgets/elevated_button_widget.dart';

class VetDetail extends StatefulWidget {
  const VetDetail({
    super.key,
    required this.vetClinic,
  });

  final VetClinic vetClinic;
  @override
  State<VetDetail> createState() => _VetDetailState();
}

class _VetDetailState extends State<VetDetail> {
  final String _appBarTitle = 'Randevu Al';

  Color cardColor = AppColor.orange;
  DateTime? selectedDate;
  final dateController = TextEditingController();
  final appointmetnNot = TextEditingController();
  DateTime? selectedTime;
  int selectedIndex = -1;

  List<DateTime> _generateTimeSlots() {
    List<DateTime> timeSlots = [];
    DateTime startTime = DateTime(2023, 5, 27, 9, 0); // Başlangıç saati 09:00
    DateTime endTime = DateTime(2023, 5, 27, 16, 30); // Bitiş saati 16:30

    while (startTime.isBefore(endTime) || startTime.isAtSameMomentAs(endTime)) {
      timeSlots.add(startTime);
      startTime = startTime.add(const Duration(minutes: 30));
    }

    return timeSlots;
  }

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
    var times = _generateTimeSlots();

    return SingleChildScrollView(
      padding: context.paddingAllLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: context.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.vetClinic.clinicLogo!),
                  radius: context.dynamicWidth(0.13),
                ),
                Container(
                  margin: context.marginTopDefault,
                  child: Text(
                    widget.vetClinic.clinicName,
                    style: context.textTheme.titleLarge,
                  ),
                ),
              ],
            ),
          ),
          _buildTitle(context, 'Hakkında'),
          widget.vetClinic.about != null
              ? Text(
                  widget.vetClinic.about!,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColor.lightBlue,
                    fontSize: 15,
                  ),
                  maxLines: 4,
                )
              : const SizedBox.shrink(),
          _buildTitle(context, 'Takvim'),
          _buildCalender(),
          _buildTitle(context, 'Saat'),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5.0, // Dikey aralıklar
              crossAxisSpacing: 5.0,
              mainAxisExtent: 50,
            ),
            itemCount: times.length,
            itemBuilder: (context, index) {
              return Center(
                  child: _buildClockItem(context, times[index], index));
            },
          ),
          TextFormField(
            controller: appointmetnNot,
            maxLines: null,
            cursorColor: AppColor.whiteColor,
            maxLength: 100,
            decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 44, 41, 41),
              filled: true,
              labelText: 'Açıklama Ekle',
              labelStyle: context.textTheme.titleMedium,
              counterStyle: const TextStyle(color: Colors.white),
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                color: AppColor.lightBlue,
              )),
            ),
            keyboardType: TextInputType.text,
          ),
          Consumer(
            builder: (context, ref, child) {
              return SizedBox(
                width: context.width,
                child: CustomElevatedButton(
                  btnTitle: 'Randevu Al',
                  borderRadius: 15,
                  btnColor: AppColor.orange,
                  onPressed: () {
                    debugPrint('submit selectdate');
                    if (selectedDate != null && selectedTime != null) {
                      Appointment newAppointment = Appointment(
                          veterinarianId: widget.vetClinic.vetClinicId!,
                          clinicName: widget.vetClinic.clinicName,
                          date: selectedDate!,
                          time: selectedTime!,
                          petName: 'kar');
                      ref
                          .read(appoinntmetnControllerProvider)
                          .addAppointment(newAppointment)
                          .then((_) => _showSuccessDialog());
                    } else {
                      const SnackBar(content: Text('Tarih boş olamaz'));
                    }
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildCalender() {
    return SizedBox(
      height: context.dynamicHeight(.07),
      child: Center(
        child: TextField(
          canRequestFocus: false,
          onTap: () {
            FocusScope.of(context).unfocus();
            _selectDate(context);
          },
          controller: dateController,
          decoration: InputDecoration(
            suffixIcon: const Icon(
              Icons.calendar_month_rounded,
              size: 30,
              color: AppColor.whiteColor,
            ),
            filled: true,
            hintText: 'Tarih',
            hintStyle: const TextStyle(color: AppColor.whiteColor),
            fillColor: AppColor.orange,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: context.defaultValue,
              vertical: context.dynamicHeight(0.01),
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector _buildClockItem(
      BuildContext context, DateTime label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          debugPrint('set state girdi');
          selectedTime = null;
          selectedIndex == index ? selectedIndex = -1 : selectedIndex = index;
          selectedTime = label;
          debugPrint('${selectedTime?.hour.toString().padLeft(2, '0')}');
        });
      },
      child: Card(
        color: selectedIndex == index ? Colors.black : AppColor.orange,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.dynamicWidth(.05),
              vertical: context.dynamicWidth(.02)),
          child: Text(
            '${label.hour.toString().padLeft(2, '0')}:${label.minute.toString().padLeft(2, '0')}',
            style: context.textTheme.labelLarge,
          ),
        ),
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      DateTime dateTime = DateTime(
        picked.year,
        picked.month,
        picked.day,
      );
      String formattedDateTime = DateFormat('dd-MM-yyyy').format(dateTime);
      debugPrint(formattedDateTime);

      setState(() {
        dateController.text = formattedDateTime;
        selectedDate = dateTime;
        debugPrint(dateController.text);
      });
    } else {}
  }

  Future<void> _showSuccessDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColor.orange,
          icon: const Icon(Icons.close_sharp),
          title: const Text('Başarılı'),
          content: const Text('Kayıt işlemi başarılı!'),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Tamam',
                style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                setState(() {
                  selectedDate = null;
                  selectedTime = null;
                  appointmetnNot.clear();
                  dateController.clear();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
