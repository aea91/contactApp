import 'package:contacts/dashboard/application/dashboard_cubit.dart';
import 'package:contacts/dashboard/domain/entity/user_dto_entity.dart';
import 'package:contacts/dashboard/presentation/widget/bottom_sheet_contact_profile.dart';
import 'package:core/extensions/context_extensions.dart';
import 'package:core/navigation/go_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uikit/bottomSheets/base_bottom_sheet.dart';
import 'package:uikit/card/base_contact_card.dart';

class ContactCardWidget extends StatelessWidget {
  const ContactCardWidget({super.key, required this.user});

  final UserDtoEntity user;

  @override
  Widget build(BuildContext context) {
    return BaseContactCard(
      onTap: () async {
        final result = await BaseBottomSheet.show(
          context: context,
          child: BottomSheetContactProfile(user: user),
        );
        if (result == true) {
          GoManager.instance.pop().then((value) {
            context.read<DashboardCubit>().pagingController.refresh();
          });
        }
      },
      firstName: user.firstName ?? "",
      lastName: user.lastName ?? "",
      phone: user.phoneNumber ?? "",
      imageUrl: user.profileImageUrl ?? "",
      theme: context.theme,
    );
  }
}
