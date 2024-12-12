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
import 'package:global/application/global_cubit.dart';
import 'package:global/application/global_state.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:uikit/bottomSheets/base_bottom_sheet.dart';
import 'package:uikit/button/base_action_button.dart';
import 'package:uikit/textfield/base_text_search_field.dart';

part 'contact_dashboard_subview.dart';

class ContactDashboardView extends StatelessWidget {
  const ContactDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            sl<DashboardCubit>()..initDashboard(globalCubit: BlocProvider.of<GlobalCubit>(context)),
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
                  const _ContactResults(),
                ],
              ),
            );
          },
        ));
  }
}
