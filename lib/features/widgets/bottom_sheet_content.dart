import 'package:flutter/material.dart';
import 'package:discover_training_location/features/widgets/custom_elevated_button%20.dart';
import 'package:discover_training_location/constants/dimensions.dart';

class BottomSheetContent extends StatelessWidget {
  final VoidCallback onTapButton;
  final String buttonText;
  final String imagePath;
  final String title;
  final String description;


  const BottomSheetContent({
    Key? key,
    required this.onTapButton,
    required this.buttonText,
    required this.imagePath,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(scaleWidth(16, context)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: scaleWidth(130, context), right: scaleWidth(130, context)),
            child: const Divider(
              thickness: 4,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: scaleHeight(10, context)),
         Text(title,
            style: TextStyle(
              fontSize: scaleWidth(18, context),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
              height: scaleHeight(200, context),
              width: scaleWidth(290, context),
              child: Image.asset(imagePath)),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: scaleWidth(16, context)),
          ),
          SizedBox(height: scaleHeight(20, context)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomElevatedButton(
                ButtonText: buttonText,
                onTapButton: onTapButton,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
