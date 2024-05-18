import 'package:discover_training_location/constants/assets_location.dart';
import 'package:discover_training_location/constants/dimensions.dart';
import 'package:discover_training_location/controllers/company_controller.dart';
import 'package:discover_training_location/themes/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CompanyMainScreen extends StatefulWidget {
  const CompanyMainScreen({Key? key}) : super(key: key);

  @override
  State<CompanyMainScreen> createState() => _CompanyMainScreenState();
}

class _CompanyMainScreenState extends State<CompanyMainScreen> {
  @override
  Widget build(BuildContext context) {
    return GetX<CompanyController>(
      init: CompanyController(),
      builder: (controller) => SafeArea(
        child: Scaffold(
          body: controller.CompanyswitchScreen(),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: controller.currentIndex == 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            Assets.navbarHome,
                            colorFilter: const ColorFilter.mode(
                              ColorStyles.defaultMainColor,
                              BlendMode.srcIn,
                            ),
                          ),
                          SvgPicture.asset(
                            Assets.navbarSelectedDot,
                            colorFilter: const ColorFilter.mode(
                              ColorStyles.defaultMainColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      )
                    : SvgPicture.asset(
                        Assets.navbarHome,
                      ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: controller.currentIndex == 1
                    ? Column(
                        children: [
                          SizedBox(
                            height: scaleHeight(30, context),
                            width: scaleWidth(30, context),
                            child: SvgPicture.asset(
                              Assets.create,
                              colorFilter: const ColorFilter.mode(
                                ColorStyles.defaultMainColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          SvgPicture.asset(
                            Assets.navbarSelectedDot,
                            colorFilter: const ColorFilter.mode(
                              ColorStyles.defaultMainColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      )
                    : SizedBox(
                        height: scaleHeight(30, context),
                        width: scaleWidth(30, context),
                        child: SvgPicture.asset(
                          Assets.create,
                        ),
                      ),
                label: 'Create Training',
              ),
              BottomNavigationBarItem(
                icon: controller.currentIndex == 2
                    ? Column(
                        children: [
                          SvgPicture.asset(
                            Assets.profile,
                            colorFilter: const ColorFilter.mode(
                              ColorStyles.defaultMainColor,
                              BlendMode.srcIn,
                            ),
                          ),
                          SvgPicture.asset(
                            Assets.navbarSelectedDot,
                            colorFilter: const ColorFilter.mode(
                              ColorStyles.defaultMainColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      )
                    : SvgPicture.asset(
                        Assets.profile,
                      ),
                label: 'Company Profile',
              ),
            ],
            currentIndex: controller.currentIndex,
            selectedItemColor: ColorStyles.defaultMainColor,
            backgroundColor: ColorStyles.pureWhite,
            onTap: (index) {
              controller.currentIndex = index;
            },
          ),
        ),
      ),
    );
  }
}
