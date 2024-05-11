import 'package:discover_training_location/constants/dimensions.dart';
import 'package:discover_training_location/themes/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class UserProfile extends StatelessWidget {
  UserProfile({Key? key}) : super(key: key);

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool rememberPassword = true;
  bool isLoading = false;
  late String fullName = '';
  late String major = '';
  String? profileImageUrl;

  @override
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
        backgroundColor: ColorStyles
            .defaultMainColor, // Set your desired background color here
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: scaleHeight(20, context)),
            Stack(
              children: [
                GestureDetector(
                  onTap: null,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 75,
                        backgroundColor: Colors.grey[300],
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : profileImageUrl != null
                                ? CircleAvatar(
                                    radius: 75,
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
                            padding: EdgeInsets.all(scaleWidth(6, context)),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(scaleWidth(10, context)),
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
            const SizedBox(height: 20),
            const ProfileMenu(
              text: "Privacy Policy",
              icon: "assets/icons/Privacy-Policy.svg",
              url:
                  "https://www.freeprivacypolicy.com/live/3aa8d923-3725-425c-b86a-75bb537ec80d",
              // backgroundColor: Color.fromARGB(65, 53, 105, 153),
            ),
            const ProfileMenu(
              text: "Settings",
              icon: "assets/icons/Settings.svg",
              // backgroundColor: Color.fromARGB(65, 53, 105, 153),
            ),
            const ProfileMenu(
              text: "Logout",
              icon: "assets/icons/Log out.svg",
              // Get.defaultDialog(
                            //   title: 'Sign out',
                            //   middleText: 'Do you really want to sign out?',
                            //   textCancel: 'No',
                            //   textConfirm: 'Yes',
                            //   confirmTextColor: ColorStyles.pureWhite,
                            //   onConfirm: () {
                            //     //   AuthFunctions.signOutUser(context);
                            //   },
                            // );
              // backgroundColor: Color.fromARGB(65, 53, 105, 153),
            ),
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
    this.url,
    this.backgroundColor,
  }) : super(key: key);

  final String? url;
  final String text, icon;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: scaleWidth(10, context),
          vertical: scaleHeight(10, context)),
      child: TextButton(
        onPressed: () {
          if (url != null) {
            launch(url!);
          } else {}
        },
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          padding: EdgeInsets.all(scaleHeight(20, context)),
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
            SizedBox(width: scaleWidth(20, context)),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(color: ColorStyles.defaultMainColor),
              ),
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
