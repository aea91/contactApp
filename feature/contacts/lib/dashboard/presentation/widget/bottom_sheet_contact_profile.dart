import 'package:contacts/dashboard/application/dashboard_cubit.dart';
import 'package:contacts/dashboard/application/dashboard_state.dart';
import 'package:contacts/dashboard/application/dashboard_status.dart';
import 'package:contacts/dashboard/domain/entity/user_dto_entity.dart';
import 'package:contacts/dashboard/presentation/widget/bottom_sheet_delete_account.dart';
import 'package:contacts/dashboard/presentation/widget/bottom_sheet_header_widget.dart';
import 'package:contacts/utils/injection_contatiner.dart';
import 'package:core/extensions/context_extensions.dart';
import 'package:core/navigation/go_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomSheetContactProfile extends StatelessWidget {
  const BottomSheetContactProfile({super.key, required this.user});

  final UserDtoEntity user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DashboardCubit>(),
      child: FractionallySizedBox(
        heightFactor: 0.9,
        child: _BottomSheetContent(user: user),
      ),
    );
  }
}

class _BottomSheetContent extends StatelessWidget {
  const _BottomSheetContent({
    super.key,
    required this.user,
  });

  final UserDtoEntity user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        if (state.status == DashboardStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Container(
          decoration: BoxDecoration(
            color: context.theme.scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Padding(
            padding: context.paddingPage,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BottomSheetHeaderWidget(
                  isDoneEnabled: true,
                  onCancel: GoManager.instance.pop,
                  onDone: GoManager.instance.pop,
                  title: "Contact Profile",
                ),
                const SizedBox(height: 40),
                _buildProfileImage(context),
                _buildInfoSection(context),
                _buildDeleteButton(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileImage(BuildContext context) => Column(
        children: [
          Center(
            child: CircleAvatar(
              radius: 98,
              backgroundImage: NetworkImage(user.profileImageUrl ?? ''),
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
          for (final info in [user.firstName, user.lastName, user.phoneNumber])
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
          onPressed: () => _showDeleteConfirmation(context),
          child: Text(
            "Delete Contact",
            style: context.textTheme.titleSmall!.copyWith(color: context.colors.error),
          ),
        ),
      );

  void _showDeleteConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => BottomSheetDeleteAccount(
        onYes: () => context.read<DashboardCubit>().deleteSingleUser(userId: user.id!),
        onNo: GoManager.instance.pop,
      ),
    );
  }
}
