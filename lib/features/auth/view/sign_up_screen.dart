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

import '../../../config/routes/route_name.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isObscureText = true;
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
        primary: false,
        child: SizedBox(
          height: context.height,
          child: Column(
            children: [
              const Expanded(
                flex: 3,
                child:
                    CircleAvatarWidget(icon: Icons.person_add_alt_1_outlined),
              ),
              const Expanded(
                flex: 1,
                child: TileWidget(
                  text: 'KAYIT OL',
                ),
              ),
              Expanded(
                flex: 4,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildFirstNameForm(userNameController),
                      _buildEmailForm(emailController),
                      _buildPasswordForm(passwordController),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
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
              btnTitle: 'Kayıt Ol',
              borderRadius: 50,
              buttonColor: AppColor.orange,
              textColor: AppColor.whiteColor,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  UserModel newUser = UserModel(
                    userName: userNameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                  );

                  ref
                      .read(authContreollerProvider)
                      .signUpWithEmailAndPassword(userModel: newUser)
                      .then(
                        (value) => Navigator.pop(context),
                      );
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
        ),
      ],
    );
  }

  Widget _buildFirstNameForm(TextEditingController fristNameController) {
    return TextFromFieldWidget(
      hintText: 'Kullanıcı Adı',
      controller: fristNameController,
      formPreIcon: Icons.person,
      textInputType: TextInputType.name,
    );
  }

  Widget _buildEmailForm(TextEditingController emailController) {
    return TextFromFieldWidget(
      hintText: 'E-mail',
      controller: emailController,
      formPreIcon: Icons.mail_outline,
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
