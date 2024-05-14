import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/config/items/app_color.dart';
import 'package:pet_friend_hub_app/config/routes/route_name.dart';
import 'package:pet_friend_hub_app/models/data/user_model.dart';

import '../../../widgets/elevated_button_widget.dart';
import '../controller/auth_controller.dart';
import '../widgets/circle_avatar_widget.dart';
import '../widgets/google_btn_view_widget.dart';
import '../widgets/texfield_widget.dart';
import '../widgets/title_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isObscureText = true;
  final String screenTitle = 'HOŞ GELDİNİZ';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
          height: context.height,
          child: Column(
            children: [
              const Expanded(
                flex: 30,
                child: CircleAvatarWidget(
                  icon: Icons.person_2_outlined,
                ),
              ),
              Expanded(
                flex: 9,
                child: TileWidget(
                  text: screenTitle,
                ),
              ),
              Expanded(
                flex: 30,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildEmailForm(),
                      _buildPasswordForm(),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 35,
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
        Consumer(
          builder: (context, ref, child) {
            return CustomElevatedButton(
              btnTitle: 'Giriş Yap',
              borderRadius: 50,
              buttonColor: AppColor.orange,
              textColor: AppColor.whiteColor,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  UserModel user = UserModel(
                      email: emailController.text,
                      password: passwordController.text);

                  ref
                      .read(authContreollerProvider)
                      .signInWithEmailAndPassword(userModel: user)
                      .then((value) =>
                          Navigator.pushNamed(context, AppRouteNames.home));
                }
              },
            );
          },
        ),
        Consumer(
          builder: (context, ref, child) {
            return GoogleBtnViewWidget(
              onTap: () {
                ref.read(authContreollerProvider).signInWithGoogle().then(
                    (value) =>
                        Navigator.pushNamed(context, AppRouteNames.home));
              },
            );
          },
        ),
        const Spacer(),
        Padding(
          padding: context.paddingVerticalLow,
          child: Row(
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
                  Navigator.pushNamed(context, AppRouteNames.signUp);
                },
                child: Text(
                  " Kayıt Ol",
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: AppColor.greenColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  TextFromFieldWidget _buildEmailForm() {
    return TextFromFieldWidget(
      hintText: 'E-mail',
      controller: emailController,
      formPreIcon: Icons.mail_outline,
    );
  }

  TextFromFieldWidget _buildPasswordForm() {
    return TextFromFieldWidget(
      hintText: 'Password',
      controller: passwordController,
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
