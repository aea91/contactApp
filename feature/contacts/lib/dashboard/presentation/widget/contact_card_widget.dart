import 'package:contacts/dashboard/domain/entity/user_dto_entity.dart';
import 'package:contacts/dashboard/presentation/widget/bottom_sheet_contact_profile.dart';
import 'package:core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:uikit/card/base_contact_card.dart';

class ContactCardWidget extends StatelessWidget {
  const ContactCardWidget({super.key, required this.user});

  final UserDtoEntity user;

  @override
  Widget build(BuildContext context) {
    return BaseContactCard(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => BottomSheetContactProfile(user: user),
        );
      },
      name: user.firstName ?? "",
      phone: user.phoneNumber ?? "",
      imageUrl: user.profileImageUrl ?? "",
      theme: context.theme,
    );
  }
}