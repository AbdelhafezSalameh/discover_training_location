import 'package:discover_training_location/features/auth/presentation/widgets/login_button.dart';
import 'package:discover_training_location/features/auth/presentation/widgets/text_fields.dart';
import 'package:discover_training_location/features/widgets/vetical_space.dart';
import 'package:discover_training_location/features/widgets/welcome_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:discover_training_location/constants/assets_location.dart';
import 'package:discover_training_location/constants/dimensions.dart';
import 'package:discover_training_location/features/home/home_screen.dart';
import 'package:discover_training_location/constants/named_routes.dart';
import 'package:discover_training_location/constants/strings.dart';

import 'package:flutter_svg/flutter_svg.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
  bool isErrorMail = false;
  bool isErrorPassword = false;
  bool isErrorFull = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 0, 0, 0),
      ),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              scaleWidth(24, context),
              0,
              scaleWidth(24, context),
              0,
            ),
            child: ListView(
              children: [
                VerticalSpace(value: 61, ctx: context),
                Row(
                  children: [
                    SvgPicture.asset(
                      Assets.splashSvg,
                    ),
                  ],
                ),
                VerticalSpace(value: 8, ctx: context),
                const WelcomeText(
                  welcomePath: Assets.helloSvg,
                  welcomeText: StaticText.welcomeBack,
                ),
                VerticalSpace(value: 52, ctx: context),
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      CustomTextField(
                        hintText: StaticText.email,
                        textIcon: Assets.mailOutlineSvg,
                        isPassword: false,
                        textType: TextInputType.emailAddress,
                        controller: _emailController,
                        isErrorfull: isErrorFull,
                        //    inputType: InputType.email,
                        formKey: _formKey,
                      ),
                      VerticalSpace(value: 16, ctx: context),
                      CustomTextField(
                        hintText: StaticText.password,
                        textIcon: Assets.passwordSvg,
                        isPassword: true,
                        textType: TextInputType.visiblePassword,
                        controller: _passWordController,
                        isErrorfull: isErrorFull,
                        //inputType: InputType.password,
                        formKey: _formKey,
                      ),
                      // if (isErrorPassword)
                      //   const ValidationError(errorText: 'Invalid password'),
                      VerticalSpace(value: 32, ctx: context),
                      LoginButton(
                          loginText: StaticText.logIn,
                          onTapButton: () => Navigator.pushNamed(
                                context,
                                NamedRoutes.mainScreen,
                              )
                          // AuthFunctions.loginUser(
                          //   emailController: _emailController,
                          //   passWordController: _passWordController,
                          //   formKey: _formKey,
                          //   context: context,
                          // ),
                          ),
                    ],
                  ),
                ),

                // FORGOT PASSWORD
                VerticalSpace(value: 32, ctx: context),

                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      NamedRoutes.resetPassword,
                    );
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: scaleWidth(15, context),
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),

                VerticalSpace(value: 48, ctx: context),

                // * CONTINUE WITH
                //   const ContinueWithOtherAccounts(isLogin: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
