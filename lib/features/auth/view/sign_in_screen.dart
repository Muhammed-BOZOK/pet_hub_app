import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/config/items/app_color.dart';
import 'package:pet_friend_hub_app/features/auth/view/sign_up_screen.dart';
import 'package:pet_friend_hub_app/features/auth/widgets/texfield_widget.dart';
import 'package:pet_friend_hub_app/widgets/elevated_button_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                flex: 3,
                child: CircleAvatar(
                  radius: context.dynamicWidth(0.2),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildEmailForm(),
                    _buildPasswordForm(),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
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
        CustomElevatedButton(
          text: 'Giriş Yap',
          borderRadius: 50,
          buttonColor: AppColor.orange,
          textColor: AppColor.whiteColor,
          onPressed: () {},
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hesabınız yok mu ?",
              style: context.textTheme.bodyLarge?.copyWith(
                color: AppColor.whiteColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                PersistentNavBarNavigator.pushDynamicScreen(
                  context,
                  screen: MaterialPageRoute(
                      builder: (context) => const SignUpScreen()),
                );
              },
              child: Text(
                " Kayıt Ol",
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

  TextFromFieldWidget _buildEmailForm() {
    return const TextFromFieldWidget(
      formPreIcon: Icons.person,
    );
  }

  TextFromFieldWidget _buildPasswordForm() {
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
