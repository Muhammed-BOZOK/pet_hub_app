import 'package:flutter/material.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/config/items/app_color.dart';
import 'package:pet_friend_hub_app/features/auth/widgets/texfield_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColor.whiteColor),
      ),
      body: _buildBody(context),
    );
  }

  Padding _buildBody(BuildContext context) {
    return Padding(
      padding: context.paddingHorizontalDefault,
      child: SingleChildScrollView(
        child: SizedBox(
          height: context.dynamicHeight(0.80),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: CircleAvatar(
                  radius: context.dynamicWidth(0.2),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    _buildEmailForm(),
                    _buildPasswordForm(),
                    _buildPasswordForm(),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: _buildBtnBox(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column _buildBtnBox(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: Text(
            'Giriş Yap',
            style: context.textTheme.titleMedium,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hesabınız var mı ?",
              style: context.textTheme.bodyLarge?.copyWith(
                color: AppColor.whiteColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                " Giriş Yap",
                style: context.textTheme.bodyLarge?.copyWith(
                  color: AppColor.greenColor,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildEmailForm() {
    return const TextFromFieldWidget(
      formPreIcon: Icons.person,
    );
  }

  Widget _buildPasswordForm() {
    return TextFromFieldWidget(
      formPreIcon: Icons.key,
      suffixIcon: GestureDetector(
        onTap: () {
          setState(() {
            isObscureText = !isObscureText;
            debugPrint(isObscureText.toString());
          });
        },
        child: Icon(
          isObscureText ? Icons.remove_red_eye : Icons.close,
        ),
      ),
      obscureText: isObscureText,
    );
  }
}
