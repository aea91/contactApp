import 'dart:io';

import 'package:contacts/dashboard/application/dashboard_cubit.dart';
import 'package:contacts/dashboard/application/dashboard_state.dart';
import 'package:contacts/dashboard/presentation/widget/bottom_sheet_header_widget.dart';
import 'package:contacts/dashboard/presentation/widget/bottom_sheet_image_select.dart';
import 'package:contacts/dashboard/presentation/widget/error_message.dart';
import 'package:contacts/dashboard/presentation/widget/success_message.dart';
import 'package:contacts/utils/icon_constant.dart';
import 'package:contacts/utils/injection_contatiner.dart';
import 'package:core/exception/exception_type.dart';
import 'package:core/extensions/context_extensions.dart';
import 'package:core/navigation/go_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:global/application/global_cubit.dart';
import 'package:uikit/bottomSheets/base_bottom_sheet.dart';
import 'package:uikit/container/base_bottom_sheet_container.dart';

class BottomSheetNewContact extends StatelessWidget {
  const BottomSheetNewContact({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<DashboardCubit>()..initNewContact(globalCubit: BlocProvider.of<GlobalCubit>(context)),
      child: FractionallySizedBox(
        heightFactor: MediaQuery.of(context).viewInsets.bottom > 0 ? 0.7 : 0.9,
        child: const _BottomSheetContent(),
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
    return BlocConsumer<DashboardCubit, DashboardState>(
      listener: (context, state) {
        if (state.exception != null) {
          if (state.exception!.type == ExceptionType.info) {
            BaseBottomSheet.show(
                context: context,
                duration: const Duration(seconds: 3),
                child: SuccessMessage(message: state.exception!.message!));
          } else {
            BaseBottomSheet.show(
                context: context,
                duration: const Duration(seconds: 3),
                child: ErrorMessage(message: state.exception!.message!));
          }
        }
      },
      builder: (context, state) {
        return BaseBottomSheetContainer(
          theme: context.theme,
          child: Padding(
            padding: context.paddingPage,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: MediaQuery.of(context).viewInsets.bottom == 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BottomSheetHeaderWidget(
                          onCancel: () {
                            GoManager.instance.pop();
                          },
                          isDoneEnabled: context.read<DashboardCubit>().isAllFieldsFilled(),
                          onDone: () async {
                            await context.read<DashboardCubit>().handleCreateUser(context: context);
                            GoManager.instance.pop<bool>(true);
                          },
                          title: "New Contact"),
                      const SizedBox(height: 40),
                      Center(
                        child: state.image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(98),
                                child: Image.file(
                                  File(state.image!),
                                  width: 196,
                                  height: 196,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : SvgPicture.asset(
                                IconConstants.instance.person,
                                width: 196,
                                height: 196,
                              ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            BaseBottomSheet.show(
                              context: context,
                              child: BottomSheetImageSelect(
                                onImageSelect: (imageSource) {
                                  if (imageSource != null) {
                                    context
                                        .read<DashboardCubit>()
                                        .handleImageSelect(imageSource: imageSource);
                                  }
                                },
                              ),
                            );
                          },
                          child: Text(
                            "Add Photo",
                            style: context.textTheme.titleSmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  onChanged: (value) =>
                      context.read<DashboardCubit>().setFirstName(firstName: value),
                  decoration: InputDecoration(
                    labelText: state.user?.firstName,
                    hintText: "First Name",
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (value) => context.read<DashboardCubit>().setLastName(lastName: value),
                  decoration: InputDecoration(
                    hintText: "Last Name",
                  ),
                ),
                const SizedBox(height: 20),
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
