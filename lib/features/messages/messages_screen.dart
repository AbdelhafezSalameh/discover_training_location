import 'package:discover_training_location/constants/assets_location.dart';
import 'package:discover_training_location/constants/dimensions.dart';
import 'package:discover_training_location/features/messages/widgets_messages/message_bar.dart';
import 'package:discover_training_location/features/messages/widgets_messages/message_search_bar.dart';
import 'package:discover_training_location/features/messages/widgets_messages/message_tile.dart';
import 'package:discover_training_location/features/messages/widgets_messages/type_of_message.dart';
import 'package:discover_training_location/features/widgets/vetical_space.dart';

import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: scaleWidth(24, context),
            vertical: scaleHeight(10, context),
          ),
          child: ListView(
            children: [
              VerticalSpace(value: 20, ctx: context),
              const MessageBar(),
              VerticalSpace(value: 16, ctx: context),
              const MessageSearchBar(),
              VerticalSpace(value: 24, ctx: context),
              const TypeOfMessage('Companies'),
              VerticalSpace(value: 8, ctx: context),
              const MessageTile(
                title: 'Google',
                imgPath: Assets.googleSvg,
                subtitle: 'Are you available for interview...',
              ),
              VerticalSpace(value: 8, ctx: context),
              const MessageTile(
                title: 'Apple',
                imgPath: Assets.appleSvg,
                subtitle: 'We are looking for a developer who...',
              ),
              VerticalSpace(value: 8, ctx: context),
              const MessageTile(
                title: 'Facebook',
                imgPath: Assets.facebookSvg,
                subtitle: 'Are you available for an on-site...',
              ),
              VerticalSpace(value: 24, ctx: context),
              const TypeOfMessage('Individual Messages'),
              VerticalSpace(value: 8, ctx: context),
              const MessageTile(
                title: 'AL HADEEL',
                imgPath: Assets.profileSvg,
                subtitle: 'Hey, how are you buddy?',
              ),
              VerticalSpace(value: 8, ctx: context),
              const MessageTile(
                title: 'AL HADEEL',
                imgPath: Assets.profileSvg,
                subtitle: 'All the best for coming interview',
              ),
              VerticalSpace(value: 8, ctx: context),
              const MessageTile(
                title: 'AL HADEEL',
                imgPath: Assets.profileSvg,
                subtitle: 'We want to hire you.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
