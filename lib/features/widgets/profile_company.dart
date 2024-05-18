import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discover_training_location/constants/assets_location.dart';
import 'package:discover_training_location/constants/dimensions.dart';
import 'package:discover_training_location/features/auth/data/controllers/auth_controller.dart';
import 'package:discover_training_location/features/auth/data/services/firebase/FireBase_Storge.dart';
import 'package:discover_training_location/features/widgets/bottom_sheet_content.dart';
import 'package:discover_training_location/features/widgets/profile_menu.dart';
import 'package:discover_training_location/themes/color_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CompanyProfile extends StatefulWidget {
  CompanyProfile({Key? key}) : super(key: key);

  @override
  _CompanyProfileState createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  final AuthController _authController = Get.find<AuthController>();

  bool isLoading = false;
  late String companyName = '';
  late String companyEmail = '';
  String? profileImageUrl;
  final FirebaseStorageService _storageService = FirebaseStorageService();

  @override
  void initState() {
    super.initState();
    profileImageUrl = null;

    fetchCompanyData().then((_) {
      setState(() {});
    });
  }

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        isLoading = true;
      });

      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final imageUrl = await _storageService.uploadProfileImage(
              File(pickedFile.path), user.uid);

          if (imageUrl != null) {
            setState(() {
              profileImageUrl = imageUrl;
            });
          }
        }
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _uploadImage(File imageFile) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final ref = FirebaseStorage.instance
            .ref()
            .child('profile_images')
            // ignore: prefer_interpolation_to_compose_strings
            .child(user.uid + '.jpg');

        await ref.putFile(imageFile);

        final imageUrl = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'profileImage': imageUrl,
        });

        setState(() {});
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }

  Future<void> fetchCompanyData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (snapshot.exists) {
          setState(() {
            companyName = snapshot.get('CompanyName') ?? 'Company Name';
            companyEmail = snapshot.get('CompanyEmail') ?? 'Company Email';
            profileImageUrl = snapshot.get('profileImage') ?? '';

            if (profileImageUrl != null) {}
          });
        }
      } catch (e) {
        // ignore: avoid_print
        print('Error fetching user data from Firestore: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Company Profile",
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
            SizedBox(height: scaleHeight(20, context)),
            Stack(
              children: [
                GestureDetector(
                onTap: _getImage,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius:scaleHeight(75, context),
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
                          padding:
                              EdgeInsets.all(scaleHeight(6, context)),
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
              ],
            ),
            Padding(
              padding: EdgeInsets.all(scaleWidth(10, context)),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      companyName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      companyEmail,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "Privacy Policy",
              icon: "assets/icons/Privacy-Policy.svg",
              url:
                  "https://www.freeprivacypolicy.com/live/3aa8d923-3725-425c-b86a-75bb537ec80d",
              onTap: () => {},
            ),
            ProfileMenu(
              text: "Settings",
              icon: "assets/icons/Settings.svg",
              onTap: () {},
            ),
            ProfileMenu(
              text: "Logout",
              icon: "assets/icons/Log out.svg",
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => BottomSheetContent(
                    onTapButton: () {
                      _authController.signOut();
                      Navigator.pop(context);
                    },
                    buttonText: 'Logout',
                    imagePath: Assets.validateCreateTrainig,
                    title: 'Confirm Logout From DTL',
                    description:
                        'Are you sure you want wo logout from discover training location?',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
