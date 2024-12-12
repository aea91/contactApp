part of 'contact_dashboard_view.dart';

class _ContactResults extends StatelessWidget {
  const _ContactResults({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PagedSliverList(
      pagingController: context.read<DashboardCubit>().pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, user, index) => Padding(
          padding: context.paddingPage,
          child: ContactCardWidget(user: user as UserDtoEntity),
        ),
        noItemsFoundIndicatorBuilder: (context) {
          return ContactDashboardEmptyWidget(
            onPressed: () {
              BaseBottomSheet.show(
                context: context,
                child: const BottomSheetNewContact(),
              );
            },
          );
        },
      ),
    );
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
        onTap: () async {
          final result = await BaseBottomSheet.show(
            context: context,
            child: const BottomSheetNewContact(),
          );
          if (result == true && context.mounted) {
            context.read<DashboardCubit>().pagingController.refresh();
            //context.read<DashboardCubit>().init();
          }
        },
        theme: context.theme,
      ),
    );
  }
}
