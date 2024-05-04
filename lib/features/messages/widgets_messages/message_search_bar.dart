import 'package:discover_training_location/constants/assets_location.dart';
import 'package:discover_training_location/themes/color_styles.dart';
import 'package:discover_training_location/constants/dimensions.dart';
import 'package:discover_training_location/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MessageSearchBar extends StatelessWidget {
  const MessageSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: ColorStyles.darkTitleColor,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: scaleWidth(24, context),
            vertical: scaleHeight(14, context),
          ),
          child: SvgPicture.asset(
            Assets.search,
          ),
        ),
        hintText: StaticText.searchChat,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            scaleRadius(12, context),
          ),
          borderSide: const BorderSide(
            color: ColorStyles.darkTitleColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            scaleRadius(12, context),
          ),
          borderSide: const BorderSide(color: ColorStyles.f2f2f3),
        ),
        // filled: true,
        // fillColor: ColorStyles.f2f2f3,
      ),
    );
  }
}
