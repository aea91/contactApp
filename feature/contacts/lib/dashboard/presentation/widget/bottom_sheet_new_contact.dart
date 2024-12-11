import 'dart:io';

import 'package:contacts/dashboard/application/dashboard_cubit.dart';
import 'package:contacts/dashboard/application/dashboard_state.dart';
import 'package:contacts/dashboard/presentation/widget/bottom_sheet_header_widget.dart';
import 'package:contacts/dashboard/presentation/widget/bottom_sheet_image_select.dart';
import 'package:contacts/utils/injection_contatiner.dart';
import 'package:core/extensions/context_extensions.dart';
import 'package:core/navigation/go_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomSheetNewContact extends StatelessWidget {
  const BottomSheetNewContact({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DashboardCubit>(),
      child: const FractionallySizedBox(
        heightFactor: 0.9,
        child: _BottomSheetContent(),
      ),
    );
  }
}

class _BottomSheetContent extends StatelessWidget {
  const _BottomSheetContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: context.theme.colorScheme.onSurface,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(0, -2),
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
                    onCancel: () {
                      GoManager.instance.pop();
                    },
                    isDoneEnabled: context.read<DashboardCubit>().isAllFieldsFilled(),
                    onDone: () {},
                    title: "New Contact"),
                SizedBox(height: 40),
                Center(
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        builder: (context) {
                          return BottomSheetImageSelect(
                            onImageSelect: (imageSource) {
                              if (imageSource != null) {
                                context
                                    .read<DashboardCubit>()
                                    .handleImageSelect(imageSource: imageSource);
                              }
                            },
                          );
                        },
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: context.theme.dividerColor,
                      backgroundImage: state.image != null ? FileImage(File(state.image!)) : null,
                      radius: 98,
                      child: Icon(
                        Icons.person,
                        size: 160,
                        color: context.theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    "Add Photo",
                    style: context.textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  onChanged: (value) =>
                      context.read<DashboardCubit>().setFirstName(firstName: value),
                  decoration: InputDecoration(
                    labelText: state.newUser?.firstName,
                    hintText: "First Name",
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  onChanged: (value) => context.read<DashboardCubit>().setLastName(lastName: value),
                  decoration: InputDecoration(
                    hintText: "Last Name",
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  onChanged: (value) =>
                      context.read<DashboardCubit>().setPhoneNumber(phoneNumber: value),
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
