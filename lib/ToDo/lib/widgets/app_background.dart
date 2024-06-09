import 'package:discover_training_location/ToDo/lib/utils/extensions.dart';
import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({super.key, this.header, this.body, this.headerHeight});
  final Widget? body;
  final Widget? header;
  final double? headerHeight;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;

    return Column(
      children: [
        Container(
          height: headerHeight,
          width: deviceSize.width,
          color: Color(0xFF2A2D3E),
          child: Center(child: header),
        ),
        Expanded(
          child: Container(
            width: deviceSize.width,
            color: colors.background,
            child: body,
          ),
        ),
      ],
    );
  }
}
