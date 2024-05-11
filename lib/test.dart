import 'package:discover_training_location/constants/assets_location.dart';
import 'package:discover_training_location/constants/dimensions.dart';
import 'package:discover_training_location/constants/named_routes.dart';
import 'package:discover_training_location/features/auth/presentation/widgets/login_button.dart';
import 'package:discover_training_location/features/auth/presentation/widgets/text_fields.dart';
import 'package:discover_training_location/features/widgets/custom_scaffold.dart';
import 'package:discover_training_location/features/widgets/vetical_space.dart';
import 'package:discover_training_location/themes/color_styles.dart';
import 'package:discover_training_location/themes/font_styles.dart';
import 'package:discover_training_location/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class TestScreen extends StatefulWidget {
  TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final TextEditingController _newPasswordController = TextEditingController();

  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool rememberPassword = true;
  bool isLoading = false;
  late String fullName = '';
  late String major = '';
  String? profileImageUrl;
  //final FirebaseStorageService _storageService = FirebaseStorageService();

  @override
  void initState() {
    super.initState();
    profileImageUrl = null;
    // fetchUserDataFromFirestore().then((_) {
    //   setState(() {});
    // });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: ColorStyles.defaultMainColor,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: scaleHeight(50, context),
            ),
            Stack(children: [
              GestureDetector(
                onTap: null,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: scaleHeight(75, context),
                      backgroundColor: Colors.grey[300],
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : profileImageUrl != null
                              ? CircleAvatar(
                                  radius: scaleHeight(75, context),
                                  backgroundImage:
                                      NetworkImage(profileImageUrl!),
                                )
                              : null,
                    ),
                    if (profileImageUrl == null)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(
                            scaleHeight(6, context),
                          ),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.all(scaleHeight(10, context)),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      fullName,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      major,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
            VerticalSpace(
              value: 20,
              ctx: context,
            ),
            ProfileMenu(
              text: "Privacy Policy",
              icon: "assets/icons/Privacy-Policy.svg",
              url:
                  "https://www.freeprivacypolicy.com/live/0909ca0e-2d46-47f4-81a3-068c8d6e58cc",
              press: () => {},
              // backgroundColor: Color.fromARGB(65, 53, 105, 153),
            ),
            ProfileMenu(
              text: "Settings",
              icon: "assets/icons/Settings.svg",
              press: () {
                //  Navigator.pushNamed(context, SettingsScreen.routeName);
              },
              //  backgroundColor: Color.fromARGB(65, 53, 105, 153),
            ),
            ProfileMenu(
              text: "Logout",
              icon: "assets/icons/Log out.svg",
              press: () {
                //   FirebaseAuth.instance.signOut();
                //   Navigator.pushNamed(context, SignInScreen.routeName);
              },
              // backgroundColor: Color.fromARGB(65, 53, 105, 153),
            ),
            // ProfileMenu(
            //   text: "Test",
            //   icon: "assets/icons/Log out.svg",
            //   press: () {
            //     Navigator.pushNamed(context, testClass.routeName);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
    this.url,
    this.backgroundColor,
  }) : super(key: key);
  final String? url;

  final String text, icon;
  final VoidCallback? press;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: scaleWidth(20, context),
          vertical: scaleHeight(10, context)),
      child: TextButton(
        onPressed: () {
          if (url != null) {
            launch(url!);
          } else if (press != null) {
            press!();
          }
        },
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: backgroundColor,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              // ignore: deprecated_member_use
              color: ColorStyles.defaultMainColor,
              width: width * 0.06,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(text,
                  style: const TextStyle(color: ColorStyles.defaultMainColor)),
            ),
            Container(
              height: height * 0.04,
              width: width * 0.08,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: ColorStyles.defaultMainColor),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
