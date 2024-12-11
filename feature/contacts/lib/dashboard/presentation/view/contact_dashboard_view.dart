import 'package:contacts/dashboard/application/dashboard_cubit.dart';
import 'package:contacts/dashboard/application/dashboard_state.dart';
import 'package:contacts/dashboard/domain/entity/user_dto_entity.dart';
import 'package:contacts/dashboard/presentation/widget/bottom_sheet_new_contact.dart';
import 'package:contacts/dashboard/presentation/widget/contact_card_widget.dart';
import 'package:contacts/dashboard/presentation/widget/contact_dashboard_empty_widget.dart';
import 'package:contacts/utils/injection_contatiner.dart';
import 'package:core/base/view/base_view.dart';
import 'package:core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:uikit/button/base_action_button.dart';
import 'package:uikit/textfield/base_text_search_field.dart';

class ContactDashboardView extends StatelessWidget {
  const ContactDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<DashboardCubit>()..init(),
        child: BlocConsumer<DashboardCubit, DashboardState>(
          listener: (context, state) {},
          builder: (context, state) {
            return BaseView(
              body: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: context.paddingPage,
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const SizedBox(height: 50),
                        const _HeaderPage(),
                        const SizedBox(height: 20),
                        const _SearchBar(),
                        const SizedBox(height: 20),
                      ]),
                    ),
                  ),
                  PagedSliverList(
                    pagingController: context.read<DashboardCubit>().pagingController,
                    builderDelegate: PagedChildBuilderDelegate(
                      itemBuilder: (context, user, index) => Padding(
                        padding: context.paddingPage,
                        child: ContactCardWidget(user: user as UserDtoEntity),
                      ),
                      noItemsFoundIndicatorBuilder: (context) {
                        return ContactDashboardEmptyWidget(
                          onPressed: () {
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
                                return const BottomSheetNewContact();
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseTextSearchField(
      hintText: "Search by name",
      theme: context.theme,
      onChanged: (value) {
        context.read<DashboardCubit>().pagingController.refresh();
        context.read<DashboardCubit>().searchUsers(search: value, pageKey: 0);
      },
    );
  }
}

class _HeaderPage extends StatelessWidget {
  const _HeaderPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
      title: Text(
        "Contacts",
        style: context.textTheme.titleLarge,
      ),
      trailing: BaseActionButton(
        icon: Icons.add,
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
              return const BottomSheetNewContact();
            },
          );
        },
        theme: context.theme,
      ),
    );
  }
}
