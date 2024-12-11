import 'dart:io';

import 'package:contacts/dashboard/application/dashboard_cubit.dart';
import 'package:contacts/dashboard/application/dashboard_state.dart';
import 'package:contacts/dashboard/application/dashboard_status.dart';
import 'package:contacts/dashboard/domain/entity/user_dto_entity.dart';
import 'package:contacts/dashboard/presentation/widget/bottom_sheet_header_widget.dart';
import 'package:contacts/dashboard/presentation/widget/bottom_sheet_image_select.dart';
import 'package:contacts/utils/injection_contatiner.dart';
import 'package:core/extensions/context_extensions.dart';
import 'package:core/navigation/go_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uikit/bottomSheets/base_bottom_sheet.dart';
import 'package:uikit/container/base_bottom_sheet_container.dart';

class BottomSheetEditContact extends StatefulWidget {
  const BottomSheetEditContact({super.key, required this.selectedUser});

  final UserDtoEntity selectedUser;

  @override
  State<BottomSheetEditContact> createState() => _BottomSheetEditContactState();
}

class _BottomSheetEditContactState extends State<BottomSheetEditContact> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    firstNameController.text = widget.selectedUser.firstName ?? "unknown";
    lastNameController.text = widget.selectedUser.lastName ?? "unknown";
    phoneNumberController.text = widget.selectedUser.phoneNumber ?? "unknown";
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DashboardCubit>()..initEditUser(selectedUser: widget.selectedUser),
      child: FractionallySizedBox(
        heightFactor: 0.9,
        child: _BottomSheetContent(
          selectedUser: widget.selectedUser,
          firstNameController: firstNameController,
          lastNameController: lastNameController,
          phoneNumberController: phoneNumberController,
        ),
      ),
    );
  }
}

class _BottomSheetContent extends StatelessWidget {
  const _BottomSheetContent({
    super.key,
    required this.selectedUser,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneNumberController,
  });

  final UserDtoEntity selectedUser;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneNumberController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        if (state.status == DashboardStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        return BaseBottomSheetContainer(
          theme: context.theme,
          child: Padding(
            padding: context.paddingPage,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(context),
                const SizedBox(height: 40),
                _buildProfileImage(context, state),
                _buildInfoSection(
                    context, firstNameController, lastNameController, phoneNumberController),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) => BottomSheetHeaderWidget(
        isDoneEnabled: true,
        onCancel: GoManager.instance.pop,
        onDone: () {
          context.read<DashboardCubit>().handleUpdateUser();
        },
        title: "Contact Profile",
        actionText: "Done",
      );

  Widget _buildProfileImage(BuildContext context, DashboardState state) => Column(
        children: [
          Center(
            child: CircleAvatar(
              radius: 98,
              backgroundImage: state.image != null
                  ? FileImage(File(state.image!))
                  : NetworkImage(selectedUser.profileImageUrl ?? ''),
            ),
          ),
          TextButton(
            onPressed: () {
              BaseBottomSheet.show(
                  context: context,
                  child: BottomSheetImageSelect(onImageSelect: (image) {
                    if (image != null) {
                      context.read<DashboardCubit>().handleImageSelect(imageSource: image);
                    }
                  }));
            },
            child: Text(
              "Change Photo",
              style: context.textTheme.titleSmall,
            ),
          ),
        ],
      );

  Widget _buildInfoSection(BuildContext context, TextEditingController firstNameController,
          TextEditingController lastNameController, TextEditingController phoneNumberController) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: firstNameController,
            onChanged: (value) => context.read<DashboardCubit>().editFirstName(firstName: value),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: lastNameController,
            onChanged: (value) => context.read<DashboardCubit>().editLastName(lastName: value),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: phoneNumberController,
            onChanged: (value) =>
                context.read<DashboardCubit>().editPhoneNumber(phoneNumber: value),
          ),
        ],
      );
}
