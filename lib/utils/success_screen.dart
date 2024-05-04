import 'package:discover_training_location/constants/dimensions.dart';
import 'package:discover_training_location/features/auth/presentation/widgets/login_button.dart';
import 'package:discover_training_location/features/widgets/vetical_space.dart';
import 'package:discover_training_location/themes/font_styles.dart';
import 'package:discover_training_location/constants/strings.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: scaleWidth(32, context),
            vertical: scaleHeight(42, context),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                StaticText.success,
                style: FontStyles.boldStyle,
              ),
              VerticalSpace(
                value: 48,
                ctx: context,
              ),
              LoginButton(
                loginText: 'Sign out',
                onTapButton: () => null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
