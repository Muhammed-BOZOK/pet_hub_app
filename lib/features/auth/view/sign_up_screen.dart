import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/config/items/app_color.dart';
import 'package:pet_friend_hub_app/features/auth/controller/auth_controller.dart';
import 'package:pet_friend_hub_app/features/auth/widgets/circle_avatar_widget.dart';
import 'package:pet_friend_hub_app/features/auth/widgets/google_btn_view_widget.dart';
import 'package:pet_friend_hub_app/features/auth/widgets/texfield_widget.dart';
import 'package:pet_friend_hub_app/features/auth/widgets/title_widget.dart';
import 'package:pet_friend_hub_app/models/data/user_model.dart';
import 'package:pet_friend_hub_app/widgets/elevated_button_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isObscureText = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //TextEditingController rpasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Padding _buildBody(BuildContext context) {
    return Padding(
      padding: context.paddingAllDefault,
      child: SingleChildScrollView(
        child: SizedBox(
          height: context.dynamicHeight(0.89),
          child: Column(
            children: [
              const Expanded(
                flex: 25,
                child:
                    CircleAvatarWidget(icon: Icons.person_add_alt_1_outlined),
              ),
              const Expanded(
                flex: 10,
                child: TileWidget(
                  text: 'KAYIT OL',
                ),
              ),
              Expanded(
                flex: 30,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildEmailForm(),
                      _buildPasswordForm(passwordController),
                      //_buildPasswordForm(rpasswordController),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 30,
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
              text: 'Kayıt Ol',
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
                      .signUpWithEmailAndPassword(userModel: user)
                      .then(
                        (value) => Navigator.pop(context),
                      );
                }
              },
            );
          },
        ),
        const GoogleBtnViewWidget(),
        const Spacer(),
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
        ),
      ],
    );
  }

  Widget _buildEmailForm() {
    return TextFromFieldWidget(
      hintText: 'E-mail',
      controller: emailController,
      formPreIcon: Icons.person,
    );
  }

  Widget _buildPasswordForm(TextEditingController passwordController) {
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
