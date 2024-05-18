import 'package:flutter/material.dart';
import 'package:discover_training_location/constants/dimensions.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.ButtonText,
    required this.onTapButton,
  }) : super(key: key);

  final String ButtonText;
  final VoidCallback onTapButton;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTapButton,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF416FDF), // Background color
        padding: EdgeInsets.symmetric(
          horizontal: scaleWidth(90, context),
          vertical: scaleHeight(16, context),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            scaleRadius(15, context),
          ),
        ),
        shadowColor: Colors.grey[50],
        elevation: scaleRadius(10, context),
      ),
      child: Text(
        ButtonText,
        style: TextStyle(
          fontFamily: 'NotoSans',
          fontSize: scaleWidth(16, context),
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
