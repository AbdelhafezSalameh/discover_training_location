import 'dart:async';

import 'package:flutter/material.dart';
import 'package:discover_training_location/themes/color_styles.dart';
import 'package:discover_training_location/constants/dimensions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PopularJobsCard extends StatefulWidget {
  const PopularJobsCard({
    Key? key,
    required this.logo,
    required this.company,
    required this.role,
    required this.salary,
    required this.color1,
    required this.color2,
    required this.duration,
  }) : super(key: key);

  final String logo;
  final String role;
  final String company;
  final String salary;
  final Color color1;
  final Color color2;
  final Duration duration;

  @override
  _PopularJobsCardState createState() => _PopularJobsCardState();
}

class _PopularJobsCardState extends State<PopularJobsCard> {
  late Color _currentColor;
  late Timer _timer;
  bool _colorChange = false;

  @override
  void initState() {
    super.initState();
    _currentColor = widget.color1;
    _timer = Timer.periodic(widget.duration, (Timer timer) {
      setState(() {
        _colorChange = !_colorChange;
        _currentColor = _colorChange ? widget.color2 : widget.color1;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration,
      width: scaleWidth(136, context),
      height: scaleHeight(164, context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(scaleRadius(24, context)),
        color: _currentColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(widget.logo),
          Text(
            widget.role,
            style: TextStyle(
              fontSize: scaleWidth(14, context),
              color: ColorStyles.c0d0d26,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            widget.company,
            style: TextStyle(
              fontSize: scaleWidth(12, context),
              color: ColorStyles.c7A7C85,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            widget.salary,
            style: TextStyle(
              fontSize: scaleWidth(12, context),
              color: ColorStyles.c0d0d26,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
