import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discover_training_location/constants/assets_location.dart';
import 'package:discover_training_location/constants/dimensions.dart';
import 'package:discover_training_location/constants/named_routes.dart';
import 'package:discover_training_location/features/auth/data/controllers/auth_functions.dart';
import 'package:discover_training_location/features/auth/data/controllers/validation.dart';
import 'package:discover_training_location/features/auth/presentation/widgets/continue_with.dart';
import 'package:discover_training_location/features/auth/presentation/widgets/login_button.dart';
import 'package:discover_training_location/features/auth/presentation/widgets/text_fields.dart';
import 'package:discover_training_location/features/widgets/vetical_space.dart';
import 'package:discover_training_location/features/widgets/welcome_text.dart';
import 'package:discover_training_location/features/home/home_screen.dart';
import 'package:discover_training_location/constants/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? fullName;
  String? email;
  String? password;
  String? confirmPassword;
  bool isErrorName = false;
  bool isErrorEmail = false;
  bool isErrorPassword = false;
  bool isErrorConfirmPassword = false;

  final _formKey = GlobalKey<FormState>();

  Future<void> saveUserDataToFirestore() async {
    try {
      // Get the current user
      final user = FirebaseAuth.instance.currentUser;

      // Get the user ID (UID)
      final String? uid = user?.uid;

      // Get the FCM token
      final token = await FirebaseMessaging.instance.getToken();

      // Save user data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'fullName': _nameController.text,
        'email': _emailController.text,
        'userId': uid,
        'deviceToken': token,
      });

      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sign-Up Successful'),
            content: Text(
              'Your Name is: ${_nameController.text}.\nYour email is: ${_emailController.text}',
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      print('User data and device token saved to Firestore successfully!');
    } catch (e) {
      print('Error saving user data to Firestore: $e');
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = FirebaseAuth.instance.currentUser;
      await user?.sendEmailVerification();
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Do not close this message!'),
            content: Text(
              'A verification email has been sent to $email. Please check your email and click on the verification link.',
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await user?.reload();
                  saveUserDataToFirestore();

                  if (mounted) {
                    if (user?.emailVerified == true) {
                      // ignore: avoid_print
                      print(
                          "heeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeey");

                      Navigator.of(context).pop();

                      Get.toNamed(NamedRoutes.logIn);
                    } else {
                      Navigator.of(context).pop();
                    }
                  }
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('An error occurred during sign-up: ${e.message}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('An unexpected error occurred: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(
            scaleWidth(24, context),
            0,
            scaleWidth(24, context),
            0,
          ),
          child: ListView(
            children: [
              VerticalSpace(value: 30, ctx: context),
              // * SPLASH IMG
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(Assets.splashSvg),
                ],
              ),
              VerticalSpace(value: 8, ctx: context),
              // * Welcome text
              const WelcomeText(
                welcomePath: Assets.thumbsUpSvg,
                welcomeText: StaticText.registration,
              ),
              VerticalSpace(value: 32, ctx: context),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: StaticText.fullName,
                      textIcon: Assets.profileSvg,
                      isPassword: false,
                      textType: TextInputType.name,
                      controller: _nameController,
                      isErrorfull: isErrorName,
                      inputType: InputType.name,
                      formKey: _formKey,
                      onSaved: (newValue) => fullName = newValue,
                    ),
                    VerticalSpace(value: 16, ctx: context),
                    CustomTextField(
                      hintText: StaticText.email,
                      textIcon: Assets.mailOutlineSvg,
                      isPassword: false,
                      textType: TextInputType.emailAddress,
                      controller: _emailController,
                      isErrorfull: isErrorEmail,
                      inputType: InputType.email,
                      formKey: _formKey,
                      onSaved: (newValue) => email = newValue,
                    ),
                    VerticalSpace(value: 16, ctx: context),
                    CustomTextField(
                      hintText: StaticText.password,
                      textIcon: Assets.passwordSvg,
                      isPassword: true,
                      textType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      isErrorfull: isErrorPassword,
                      inputType: InputType.password,
                      formKey: _formKey,
                      onSaved: (newValue) => password = newValue,
                    ),
                    VerticalSpace(value: 16, ctx: context),
                    CustomTextField(
                      hintText: StaticText.confirmPassword,
                      textIcon: Assets.passwordSvg,
                      isPassword: true,
                      textType: TextInputType.visiblePassword,
                      controller: _confirmPasswordController,
                      isErrorfull: isErrorConfirmPassword,
                      inputType: InputType.confirmPassword,
                      formKey: _formKey,
                      onSaved: (newValue) => confirmPassword = newValue,
                    ),
                    // if (isErrorPassword)
                    //   const ValidationError(errorText: "Passwords don't match"),
                    VerticalSpace(value: 20, ctx: context),
                    LoginButton(
                      loginText: StaticText.register,
                      onTapButton: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          signUp(email!, password!);
                          print("FullName is: $fullName");
                          print("email is: $email");
                          print("Pass is: $password");

                          Navigator.pushNamed(
                            context,
                            NamedRoutes.logIn,
                          );
                        } else {
                          print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
                        }
                      },
                    ),
                  ],
                ),
              ),

              VerticalSpace(
                value: 20,
                ctx: context,
              ),
              const ContinueWithOtherAccounts(
                isLogin: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
