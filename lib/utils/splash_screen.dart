import 'package:discover_training_location/constants/assets_location.dart';
import 'package:discover_training_location/themes/color_styles.dart';
import 'package:discover_training_location/constants/dimensions.dart';
import 'package:discover_training_location/constants/named_routes.dart';
import 'package:discover_training_location/constants/route_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(
          seconds: 1,
        ), () {
      // final user = FirebaseAuth.instance.currentUser;
      if (true) {
        AppRoute.offNamed(NamedRoutes.logIn);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: Container(
          width: width(context),
          height: height(context),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorStyles.splashGradient1,
                ColorStyles.splashGradient2
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: scaleWidth(
                80,
                context,
              ),
              vertical: scaleHeight(
                88,
                context,
              ),
            ),
            child: SvgPicture.asset(
              Assets.splashSvg,
              colorFilter: const ColorFilter.mode(
                ColorStyles.pureWhite,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
