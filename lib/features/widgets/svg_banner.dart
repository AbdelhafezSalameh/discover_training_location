import 'package:discover_training_location/constants/assets_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgBanner extends StatelessWidget {
  const SvgBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      Assets.splashSvg,
    );
  }
}
