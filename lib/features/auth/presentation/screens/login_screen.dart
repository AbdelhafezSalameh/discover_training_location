import 'package:discover_training_location/features/auth/presentation/widgets/login_button.dart';
import 'package:discover_training_location/features/auth/presentation/widgets/text_fields.dart';
import 'package:discover_training_location/features/widgets/custom_scaffold.dart';
import 'package:discover_training_location/features/widgets/horizontal_space.dart';
import 'package:discover_training_location/features/widgets/vetical_space.dart';
import 'package:discover_training_location/features/widgets/welcome_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:discover_training_location/constants/assets_location.dart';
import 'package:discover_training_location/constants/dimensions.dart';
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
  bool rememberPassword = true;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 0, 0, 0),
      ),
      child: CustomScaffold(
        child: Column(
          children: [
            const Expanded(
              flex: 1,
              child: SizedBox(
                height: 10,
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 20.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    scaleWidth(24, context),
                    0,
                    scaleWidth(24, context),
                    0,
                  ),
                  child: ListView(
                    children: [
                      VerticalSpace(value: 8, ctx: context),
                      WelcomeText(
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: rememberPassword,
                            onChanged: (bool? value) {
                              setState(() {
                                rememberPassword = value!;
                              });
                            },
                            activeColor: Color(0xFF416FDF),
                          ),
                          const Text(
                            'Remember me',
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                          HorizontalSpace(value: 50, ctx: context),
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
                                fontSize: scaleWidth(12, context),
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF416FDF),
                              ),
                            ),
                          ),
                        ],
                      ),
                      VerticalSpace(value: 20, ctx: context),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 10,
                            ),
                            child: Text(
                              'Sign up with',
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account? ',
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                NamedRoutes.resetPassword,
                              );
                            },
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF416FDF),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // * CONTINUE WITH
                      //   const ContinueWithOtherAccounts(isLogin: true),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
