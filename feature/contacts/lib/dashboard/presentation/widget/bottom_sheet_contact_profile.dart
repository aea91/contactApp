import 'package:contacts/dashboard/application/dashboard_cubit.dart';
import 'package:contacts/dashboard/application/dashboard_state.dart';
import 'package:contacts/dashboard/domain/entity/user_dto_entity.dart';
import 'package:contacts/dashboard/presentation/widget/bottom_sheet_delete_account.dart';
import 'package:contacts/dashboard/presentation/widget/bottom_sheet_edit_contact.dart';
import 'package:contacts/dashboard/presentation/widget/bottom_sheet_header_widget.dart';
import 'package:contacts/dashboard/presentation/widget/error_message.dart';
import 'package:contacts/dashboard/presentation/widget/success_message.dart';
import 'package:contacts/utils/injection_contatiner.dart';
import 'package:core/exception/exception_type.dart';
import 'package:core/extensions/context_extensions.dart';
import 'package:core/navigation/go_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global/application/global_cubit.dart';
import 'package:uikit/bottomSheets/base_bottom_sheet.dart';
import 'package:uikit/container/base_bottom_sheet_container.dart';

class BottomSheetContactProfile extends StatelessWidget {
  const BottomSheetContactProfile({super.key, required this.user});

  final UserDtoEntity user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DashboardCubit>()
        ..initContactProfile(globalCubit: BlocProvider.of<GlobalCubit>(context)),
      child: BlocConsumer<DashboardCubit, DashboardState>(
        listener: (context, state) {
          if (state.exception != null) {
            if (state.exception?.type == ExceptionType.info) {
              BaseBottomSheet.show(
                context: context,
                duration: Duration(seconds: 3),
                child: SuccessMessage(message: state.exception?.message ?? ""),
              );
              GoManager.instance.pop();
            } else {
              BaseBottomSheet.show(
                context: context,
                duration: Duration(seconds: 3),
                child: ErrorMessage(message: state.exception?.message ?? ""),
              );
              GoManager.instance.pop();
            }
          }
        },
        builder: (context, state) => FractionallySizedBox(
          heightFactor: 0.9,
          child: _BottomSheetContent(selectedUser: user),
        ),
      ),
    );
  }
}

class _BottomSheetContent extends StatelessWidget {
  const _BottomSheetContent({
    super.key,
    required this.selectedUser,
  });

  final UserDtoEntity selectedUser;

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheetContainer(
      theme: context.theme,
      padding: context.paddingPage,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context),
          const SizedBox(height: 40),
          _buildProfileImage(context),
          _buildInfoSection(context),
          _buildDeleteButton(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) => BottomSheetHeaderWidget(
        isDoneEnabled: true,
        onCancel: GoManager.instance.pop,
        onDone: () {
          BaseBottomSheet.show(
              context: context, child: BottomSheetEditContact(selectedUser: selectedUser));
        },
        title: "Contact Profile",
        actionText: "Edit",
      );

  Widget _buildProfileImage(BuildContext context) => Column(
        children: [
          Center(
            child: CircleAvatar(
              radius: 98,
              backgroundImage: selectedUser.profileImageUrl != null
                  ? NetworkImage(selectedUser.profileImageUrl!)
                  : null,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "Change Photo",
              style: context.textTheme.titleSmall,
            ),
          ),
        ],
      );

  Widget _buildInfoSection(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final info in [
            selectedUser.firstName,
            selectedUser.lastName,
            selectedUser.phoneNumber
          ])
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(info ?? "unknown", style: context.textTheme.titleSmall),
                const Divider(thickness: 1),
              ],
            ),
        ],
      );

  Widget _buildDeleteButton(BuildContext context) => BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) => TextButton(
          onPressed: () {
            _showDeleteConfirmation(context);
          },
          child: Text(
            "Delete Contact",
            style: context.textTheme.titleSmall!.copyWith(color: context.colors.error),
          ),
        ),
      );

  void _showDeleteConfirmation(BuildContext context) async {
    BaseBottomSheet.show(
      context: context,
      child: BottomSheetDeleteAccount(
        onYes: () async {
          await context.read<DashboardCubit>().deleteSingleUser(id: selectedUser.id!);
        },
        onNo: GoManager.instance.pop,
      ),
    );
  }
}
