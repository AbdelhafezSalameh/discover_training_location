import 'package:discover_training_location/constants/assets_location.dart';
import 'package:discover_training_location/constants/dimensions.dart';
import 'package:discover_training_location/controllers/company_controller.dart';
import 'package:discover_training_location/features/widgets/vetical_space.dart';
import 'package:discover_training_location/themes/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:discover_training_location/modals/data/full_training_model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class FullTraining extends StatefulWidget {
  final Training training;

  FullTraining({Key? key, required this.training}) : super(key: key);

  @override
  State<FullTraining> createState() => _FullTrainingState();
}

class _FullTrainingState extends State<FullTraining> {
  String? profileImageUrl;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: screenHeight(context) * 0.5,
            child: Stack(
              children: [
                SvgPicture.asset(
                  Assets.detailsContainer,
                  width: screenWidth(context),
                  height: screenHeight(context) * 0.466,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: ColorStyles.pureWhite,
                        ),
                        child: CircleAvatar(
                          radius: scaleHeight(30, context),
                          backgroundColor: Colors.grey[300],
                          child: isLoading
                              ? const CircularProgressIndicator()
                              : profileImageUrl != null
                                  ? CircleAvatar(
                                      radius: scaleHeight(30, context),
                                      backgroundImage:
                                          NetworkImage(profileImageUrl!),
                                    )
                                  : null,
                        ),
                      ),
                      VerticalSpace(
                        value: scaleHeight(24, context),
                        ctx: context,
                      ),
                      Text(
                        widget.training.description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          color: ColorStyles.pureWhite,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      VerticalSpace(
                        value: scaleHeight(8, context),
                        ctx: context,
                      ),
                      Text(
                        widget.training.description,
                        style: const TextStyle(
                          fontSize: 16,
                          color: ColorStyles.pureWhite,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      VerticalSpace(
                        value: scaleHeight(32, context),
                        ctx: context,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ColorStyles.c26FFFFFF,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: scaleWidth(16, context),
                              vertical: scaleHeight(5, context),
                            ),
                            child: Text(
                              widget.training.description,
                              style: TextStyle(
                                fontSize: scaleWidth(11, context),
                                color: ColorStyles.pureWhite,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: ColorStyles.c26FFFFFF,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: scaleWidth(16, context),
                              vertical: scaleHeight(5, context),
                            ),
                            child: Text(
                              widget.training.description,
                              style: TextStyle(
                                fontSize: scaleWidth(11, context),
                                color: ColorStyles.pureWhite,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: ColorStyles.c26FFFFFF,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: scaleWidth(16, context),
                              vertical: scaleHeight(5, context),
                            ),
                            child: Text(
                              widget.training.description,
                              style: TextStyle(
                                fontSize: scaleWidth(11, context),
                                color: ColorStyles.pureWhite,
                              ),
                            ),
                          ),
                          // for (int i = 0; i < 3; i++) ...{
                          //   if (i >= extensionsList.length ||
                          //       extensionsList[i].toString().length > 12) ...{
                          //     Pill(pillRandom[Random().nextInt(2)]),
                          //     HorizontalSpace(value: 4, ctx: context),
                          //   } else ...{
                          //     Pill(extensionsList[i] as String),
                          //     HorizontalSpace(value: 4, ctx: context),
                          //   }
                          // },
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: scaleHeight(8, context),
                horizontal: scaleWidth(24, context),
              ),
              child: GetX<CompanyController>(
                init: CompanyController(),
                builder: (tab) => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            tab.switchTab = 0;
                          },
                          child: Text(
                            'Description',
                            style: TextStyle(
                              color: tab.tabController == 0
                                  ? Colors.black
                                  : Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            tab.switchTab = 1;
                          },
                          child: Text(
                            'Responsibilities',
                            style: TextStyle(
                              color: tab.tabController == 1
                                  ? Colors.black
                                  : Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            tab.switchTab = 2;
                          },
                          child: Text(
                            'Benefits',
                            style: TextStyle(
                              color: tab.tabController == 2
                                  ? Colors.black
                                  : Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            if (tab.tabController == 0) ...{
                              Text(widget.training.description.toString()),
                            } else if (tab.tabController == 1) ...{
                              Text(widget.training.description.toString()),
                            } else ...{
                              Text(widget.training.description.toString()),
                            }
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResponsibilitiesList(List<dynamic>? responsibilities) {
    if (responsibilities == null || responsibilities.isEmpty) {
      return Text('No responsibilities found.');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: responsibilities
          .map((responsibility) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('\u2022 ${responsibility.toString()}'),
                  SizedBox(height: 8),
                ],
              ))
          .toList(),
    );
  }

  Widget _buildBenefitsList(List<dynamic>? benefits) {
    if (benefits == null || benefits.isEmpty) {
      return Text('No benefits found.');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: benefits
          .map((benefit) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('\u2022 ${benefit.toString()}'),
                  SizedBox(height: 8),
                ],
              ))
          .toList(),
    );
  }
}
