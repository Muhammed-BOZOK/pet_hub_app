import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/config/items/app_color.dart';
import 'package:pet_friend_hub_app/features/vet_and_appointment/controller/appointment_controller.dart';

import '../widgets/my_appointment_card_widget.dart';
import '../widgets/vet_item_card_widgeet.dart';

class VetAppointmentScreen extends StatefulWidget {
  const VetAppointmentScreen({super.key});

  static const List<Tab> myTabs = <Tab>[
    Tab(
      text: 'Randevularım',
    ),
    Tab(text: 'Klinikler'),
  ];

  @override
  State<VetAppointmentScreen> createState() => _VetAppointmentScreenState();
}

class _VetAppointmentScreenState extends State<VetAppointmentScreen> {
  int isSection = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: VetAppointmentScreen.myTabs.length,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: TabBarView(children: [
          _viewMyAppointmentsBdoy(),
          _viewVetsBody(context),
        ]),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Klinik Seçimi',
        style: context.textTheme.titleLarge,
      ),
      bottom: TabBar(
        onTap: (index) {
          setState(() {
            isSection = index;
          });
          debugPrint(isSection.toString());
        },
        dividerHeight: 0,
        unselectedLabelColor: Colors.blue,
        indicatorColor: AppColor.lightBlue,
        labelColor: AppColor.lightBlue,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        tabs: VetAppointmentScreen.myTabs,
      ),
      actions: isSection == 1
          ? [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.filter_list_rounded,
                  color: AppColor.lightBlue,
                  size: 30,
                ),
              )
            ]
          : null,
    );
  }

  Widget _viewVetsBody(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return FutureBuilder(
          future: ref.read(appoinntmetnControllerProvider).getVetClinics(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var vetClinics = snapshot.data;

              return Padding(
                padding: context.paddingHorizontalDefault,
                child: ListView.builder(
                  itemCount: vetClinics?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: context.paddingBottomLow,
                      child: VetItemCardWidget(
                        vetClinic: vetClinics![index],
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: Text("Error"));
            }
          },
        );
      },
    );
  }

  Widget _viewMyAppointmentsBdoy() {
    return Consumer(
      builder: (context, ref, child) {
        return FutureBuilder(
          future:
              ref.read(appoinntmetnControllerProvider).getAppointmentOfUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var appointments = snapshot.data;
              return ListView.builder(
                padding: context.paddingAllDefault,
                itemCount: appointments?.length,
                itemBuilder: (context, index) {
                  return MyAppoinmentCardWidget(
                    appointment: appointments![index],
                  );
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.data == null) {
              return Center(
                child: _viewEmpty(context, "Randevunuz bulunmamaktadır"),
              );
            } else {
              return const Center(
                child: Text('ERROR'),
              );
            }
          },
        );
      },
    );
  }

  Widget _viewEmpty(BuildContext context, String text) {
    return Center(
      child: Text(
        text,
        style: context.textTheme.bodyMedium,
      ),
    );
  }
}
