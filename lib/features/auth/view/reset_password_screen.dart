import 'package:flutter/material.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/config/items/app_color.dart';

import '../../../widgets/elevated_button_widget.dart';
import '../widgets/texfield_widget.dart';

class ResetPassworScreen extends StatefulWidget {
  const ResetPassworScreen({super.key});

  @override
  State<ResetPassworScreen> createState() => _ResetPassworScreenState();
}

class _ResetPassworScreenState extends State<ResetPassworScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(),
    );
  }

  Form _buildBody() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: context.paddingAllDefault,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: context.margnBottomHigh,
              height: context.dynamicHeight(.15),
              width: context.dynamicWidth(.30),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColor.lightBlue,
                  ),
                  borderRadius: BorderRadius.circular(100)),
              child: Icon(
                Icons.lock_open_rounded,
                color: AppColor.whiteColor,
                size: context.dynamicHeight(.1),
              ),
            ),
            _buildEmailForm(),
            SizedBox(
              height: context.dynamicHeight(.07),
            ),
            _submitBtn(),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Şifreni hatırladın mı?",
                  style: context.textTheme.bodyMedium,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Giriş Yap",
                      style: context.textTheme.bodyLarge,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  SizedBox _submitBtn() {
    return SizedBox(
      height: context.dynamicHeight(.07),
      child: CustomElevatedButton(
        paddingVertical: 0,
        btnTitle: 'Gönder',
        onPressed: () {},
        borderRadius: 50,
        btnColor: AppColor.orange,
      ),
    );
  }

  TextFromFieldWidget _buildEmailForm() {
    return TextFromFieldWidget(
      hintText: 'E-mail',
      controller: emailController,
      formPreIcon: Icons.mail_outline,
    );
  }
}
