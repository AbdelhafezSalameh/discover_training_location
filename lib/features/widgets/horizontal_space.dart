import 'package:flutter/material.dart';
import 'package:discover_training_location/constants/dimensions.dart';

class HorizontalSpace extends StatelessWidget {
  const HorizontalSpace({super.key, required this.value, required this.ctx});
  final double value;
  final BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: scaleWidth(value, ctx),
    );
  }
}
