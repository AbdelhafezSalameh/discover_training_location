import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discover_training_location/themes/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:discover_training_location/constants/assets_location.dart';
import 'package:discover_training_location/constants/dimensions.dart';
import 'package:discover_training_location/constants/named_routes.dart';
import 'package:discover_training_location/features/auth/data/controllers/validation.dart';
import 'package:discover_training_location/features/auth/presentation/widgets/continue_with.dart';
import 'package:discover_training_location/features/auth/presentation/widgets/login_button.dart';
import 'package:discover_training_location/features/auth/presentation/widgets/text_fields.dart';
import 'package:discover_training_location/features/widgets/custom_scaffold.dart';
import 'package:discover_training_location/features/widgets/vetical_space.dart';
import 'package:discover_training_location/features/widgets/welcome_text.dart';
import 'package:discover_training_location/constants/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  void _handleTabChange() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _companyEmailController = TextEditingController();
  final TextEditingController _companyPasswordController =
      TextEditingController();
  final TextEditingController _CompanyLocationController =
      TextEditingController();
  final TextEditingController _CompanyContactController =
      TextEditingController();
  final TextEditingController _companyProofController = TextEditingController();

  String? fullName;
  String? email;
  String? password;
  String? confirmPassword;

  String? companyName;
  String? companyEmail;
  String? companyPassword;
  String? companyLocation;
  String? companyContact;
  String? companyProof;

  bool isErrorName = false;
  bool isErrorEmail = false;
  bool isErrorPassword = false;
  bool isErrorConfirmPassword = false;

  bool isErrorCompanyName = false;
  bool isErrorCompanyEmail = false;
  bool isErrorCompanyPassword = false;
  bool isErrorCompanyLocation = false;
  bool isErrorCompanyContact = false;
  bool isErrorCompanyProof = false;

  final _formKey = GlobalKey<FormState>();
  final _formKeyCompany = GlobalKey<FormState>();

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
                'role': 'student'

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

  Future<void> signUpCompany(
      String companyEmail, String companyPassword) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: companyEmail,
        password: companyPassword,
      );
      User? user = FirebaseAuth.instance.currentUser;
      await user?.sendEmailVerification();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Do not close this message!'),
            content: Text(
              'A verification email has been sent to $companyEmail. Please check your email and click on the verification link.',
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await user?.reload();
                  CompanysaveUserDataToFirestore();

                  if (mounted) {
                    if (user?.emailVerified == true) {
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

  Future<void> CompanysaveUserDataToFirestore() async {

    try {
      // Get the current user
      final user = FirebaseAuth.instance.currentUser;
      // Get the user ID (UID)
      final String? uid = user?.uid;

      // Get the FCM token
      final token = await FirebaseMessaging.instance.getToken();

      // Save user data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'CompanyName': _companyNameController.text,
        'CompanyEmail': _companyEmailController.text,
        'CompanyLocation': _CompanyLocationController.text,
        'CompanyContact': _CompanyContactController.text,
        'CompanyProof': _companyProofController.text,
        'userId': uid,
        'deviceToken': token,
        'role': 'company'
      });

      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sign-Up Successful'),
            content: Text(
              'Your Name is: ${_companyNameController.text}.\nYour email is: ${_companyEmailController.text}',
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        child: Column(
          children: [
            VerticalSpace(value: 100, ctx: context),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildRegistrationStudent(),
                          _buildRegistrationCompany(),
                        ],
                      ),
                    ),
                    _buildDotsIndicator(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 2; i++)
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: i == _tabController.index ? 20 : 10,
              height: 10,
              decoration: BoxDecoration(
                shape: i == _tabController.index
                    ? BoxShape.rectangle
                    : BoxShape.circle,
                borderRadius:
                    i == _tabController.index ? BorderRadius.circular(5) : null,
                color: i == _tabController.index
                    ? ColorStyles.defaultMainColor
                    : Colors.grey.withOpacity(0.5),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildRegistrationStudent() {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: scaleHeight(0, context),
              horizontal: scaleWidth(24, context),
            ),
            child: ListView(
              children: [
                VerticalSpace(value: 20, ctx: context),
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
                        onSaved: (newValue) => fullName = newValue,
                        formKey: _formKey,
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
                        onSaved: (newValue) => email = newValue,
                        formKey: _formKey,
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
                        onSaved: (newValue) => password = newValue,
                        formKey: _formKey,
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
                        onSaved: (newValue) => confirmPassword = newValue,
                        formKey: _formKey,
                      ),
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
                VerticalSpace(value: 20, ctx: context),
                ContinueWithOtherAccounts(isLogin: false),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegistrationCompany() {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: scaleHeight(0, context),
              horizontal: scaleWidth(24, context),
            ),
            child: ListView(
              children: [
                VerticalSpace(value: 20, ctx: context),
                const WelcomeText(
                  welcomePath: Assets.thumbsUpSvg,
                  welcomeText: StaticText.registration,
                ),
                VerticalSpace(value: 32, ctx: context),
                Form(
                  key: _formKeyCompany,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      CustomTextField(
                        hintText: StaticText.companyName,
                        textIcon: Assets.profileSvg,
                        isPassword: false,
                        textType: TextInputType.name,
                        controller: _companyNameController,
                        isErrorfull: isErrorCompanyName,
                        inputType: InputType.name,
                        onSaved: (newValue) => companyName = newValue,
                        formKey: _formKeyCompany,
                      ),
                      VerticalSpace(value: 16, ctx: context),
                      CustomTextField(
                        hintText: StaticText.emailCompany,
                        textIcon: Assets.mailOutlineSvg,
                        isPassword: false,
                        textType: TextInputType.emailAddress,
                        controller: _companyEmailController,
                        isErrorfull: isErrorCompanyEmail,
                        inputType: InputType.email,
                        onSaved: (newValue) => companyEmail = newValue,
                        formKey: _formKeyCompany,
                      ),
                      VerticalSpace(value: 16, ctx: context),
                      CustomTextField(
                        hintText: StaticText.password,
                        textIcon: Assets.passwordSvg,
                        isPassword: true,
                        textType: TextInputType.visiblePassword,
                        controller: _companyPasswordController,
                        isErrorfull: isErrorCompanyPassword,
                        inputType: InputType.password,
                        onSaved: (newValue) => companyPassword = newValue,
                        formKey: _formKeyCompany,
                      ),
                      VerticalSpace(value: 16, ctx: context),
                      CustomTextField(
                        hintText: StaticText.LocationCompany,
                        textIcon: Assets.passwordSvg,
                        isPassword: false,
                        textType: TextInputType.visiblePassword,
                        controller: _CompanyLocationController,
                        isErrorfull: isErrorCompanyLocation,
                        inputType: InputType.name,
                        onSaved: (newValue) => companyLocation = newValue,
                        formKey: _formKeyCompany,
                      ),
                      VerticalSpace(value: 16, ctx: context),
                      CustomTextField(
                        hintText: StaticText.contactCompany,
                        textIcon: Assets.passwordSvg,
                        isPassword: false,
                        textType: TextInputType.visiblePassword,
                        controller: _CompanyContactController,
                        isErrorfull: isErrorCompanyContact,
                        inputType: InputType.number,
                        onSaved: (newValue) => companyContact = newValue,
                        formKey: _formKeyCompany,
                      ),
                      VerticalSpace(value: 16, ctx: context),
                      CustomTextField(
                        hintText: StaticText.proofCompany,
                        textIcon: Assets.passwordSvg,
                        isPassword: false,
                        textType: TextInputType.visiblePassword,
                        controller: _companyProofController,
                        isErrorfull: isErrorCompanyProof,
                        inputType: InputType.name,
                        onSaved: (newValue) => companyProof = newValue,
                        formKey: _formKeyCompany,
                      ),
                      VerticalSpace(value: 20, ctx: context),
                      LoginButton(
                        loginText: StaticText.registerCompany,
                        onTapButton: () {
                          if (_formKeyCompany.currentState!.validate()) {
                            _formKeyCompany.currentState!.save();
                            signUpCompany(companyEmail!, companyPassword!);
                            print("Company Name is: $companyName");
                            print("Company Email is: $companyEmail");
                            print("Company Pass is: $companyPassword");

                            Navigator.pushNamed(
                              context,
                              NamedRoutes.logIn,
                            );
                          } else {
                            print("Company Company Company Company Company");
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
