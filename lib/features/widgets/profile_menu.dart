import 'package:discover_training_location/constants/dimensions.dart';
import 'package:discover_training_location/themes/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileMenu extends StatelessWidget {
  final String? url;
  final String text, icon;
  final VoidCallback? onTap;

  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.onTap,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: scaleWidth(10, context),
        vertical: scaleHeight(10, context),
      ),
      child: TextButton(
        onPressed: () async {
          if (url != null) {
            if (await canLaunch(url!)) {
              await launch(url!);
            } else {
              throw 'Could not launch $url';
            }
          } else if (onTap != null) {
            onTap!();
          }
        },
        style: TextButton.styleFrom(
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.all(scaleHeight(20, context)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: ColorStyles.defaultMainColor.withOpacity(0.2),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
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
                color: ColorStyles.defaultMainColor,
              ),
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
