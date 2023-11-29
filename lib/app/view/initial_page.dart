import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:blueprint/app/routes/routes.dart';
import 'package:blueprint/users/presentation/widgets/profile_menu.dart';
import 'package:blueprint/users/state_management/cubit/user_cubit.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final navigationPages = [
  NavigationPageData(
    text: 'Todays Blueprint',
    icon: Icons.today,
    route: const TodaysBlueprintRoute(),
  ),
  NavigationPageData(
    text: 'Might Do',
    icon: Icons.task_sharp,
    route: const TasksRoute(),
  ),
  NavigationPageData(
    text: 'Integrations',
    icon: Icons.integration_instructions,
    route: const IntegrationsRoute(),
  ),
];

class NavigationPageData<T> {
  NavigationPageData({
    required this.text,
    required this.icon,
    required this.route,
  });

  final String text;
  final IconData icon;
  final PageRouteInfo<T> route;
}

// An scaffold with a material side bar with the navigation options in case
// is not in mobile. If mobile, then is a bottom app bar with the navigation
// options.
@RoutePage()
class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  late int currentIndex;
  @override
  void initState() {
    context.read<UserCubit>().loadUserData();
    currentIndex = 0;
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is Loaded) {
            final userData = state.user;
            return Column(
              children: [
                Container(
                  height: size.height * 0.32,
                  padding: const EdgeInsets.only(
                    top: AppSpacing.lg,
                    right: AppSpacing.lg,
                  ),
                  child: Drawer(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppSpacing.lg),
                      ),
                    ),
                    child: ProfileMenuView(
                      userDisplayName: userData.displayName,
                      userEmail: userData.email,
                      //don't know how we suppost to save the whole
                      //user name to get the letter of the lastname
                      //for now just grabbing the first and the second
                      //ones of the name
                      userInitials:
                          userData.displayName.substring(0, 2).toUpperCase(),
                    ),
                  ),
                ),
              ],
            );
          }
          //not sure what to show when it fails
          else {
            return const SizedBox();
          }
        },
      ),
      body: Builder(
        builder: (context) {
          final isPhone = MediaQuery.of(context).size.width < 600;

          return Theme(
            data: Theme.of(context).copyWith(
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: const Color(0xFF121212),
                unselectedItemColor: Colors.white54,
                selectedItemColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            child: AutoTabsRouter(
              routes: const [
                TodaysBlueprintRoute(),
                TasksRoute(),
                IntegrationsRoute(),
              ],
              transitionBuilder: (context, child, animation) => FadeTransition(
                opacity: animation,
                // the passed child is technically our animated
                //selected-tab page
                child: child,
              ),
              builder: (context, child) {
                // obtain the scoped TabsRouter controller using context
                final tabsRouter = AutoTabsRouter.of(context);
                // Here we're building our Scaffold inside of AutoTabsRouter
                // to access the tabsRouter controller provided in this context

                return Scaffold(
                  bottomNavigationBar: isPhone
                      ? BottomNavigationBar(
                          currentIndex: tabsRouter.activeIndex,
                          onTap: tabsRouter.setActiveIndex,
                          items: navigationPages
                              .map(
                                (e) => BottomNavigationBarItem(
                                  icon: Icon(
                                    e.icon,
                                  ),
                                  label: e.text,
                                ),
                              )
                              .toList(),
                        )
                      : null,
                  appBar: TopAppBar(
                    //title suppost to be the old search bar but is not
                    //in the desing so waiting for a final desicion
                    title: const Text(''),
                    trailing: BlocBuilder<UserCubit, UserState>(
                      builder: (context, state) {
                        if (state is Loaded) {
                          return InkWell(
                            onTap: () {
                              _scaffoldKey.currentState?.openEndDrawer();
                            },
                            child: AvatarIcon(
                              text: state.user.displayName
                                  .substring(0, 2)
                                  .toUpperCase(),
                            ),
                          );
                        } else {
                          return const AvatarIcon(text: '');
                        }
                      },
                    ),
                  ),
                  body: isPhone
                      ? child
                      : SidebarPage(
                          navigationPages: navigationPages,
                          onPageChanged: tabsRouter.setActiveIndex,
                          child: child,
                        ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class SidebarPage extends StatefulWidget {
  const SidebarPage({
    required this.child,
    required this.onPageChanged,
    required this.navigationPages,
    super.key,
  });
  final Widget child;
  final List<NavigationPageData<dynamic>> navigationPages;
  final void Function(int index) onPageChanged;

  @override
  State<SidebarPage> createState() => _SidebarPageState();
}

class _SidebarPageState extends State<SidebarPage> {
  late int currentPage;

  @override
  void initState() {
    super.initState();

    currentPage = 0;
  }

  void onPageChanged(int index) {
    widget.onPageChanged(index);
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;
    return CollapsibleSidebar(
      isCollapsed: false,
      items: widget.navigationPages
          .mapIndexed(
            (index, e) => CollapsibleItem(
              text: e.text,
              icon: e.icon,
              isSelected: widget.navigationPages.indexOf(e) == currentPage,
              onPressed: () => onPageChanged(index),
            ),
          )
          .toList(),
      collapseOnBodyTap: false,
      avatarImg: const NetworkImage(
        'https://images.unsplash.com/photo-1483058712412-4245e9b90334?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
      ),
      body: Row(
        children: [
          SizedBox(width: isMobile ? 0 : 164),
          Expanded(child: widget.child),
        ],
      ),
      showTitle: false,
      iconSize: 28,
      toggleTitle: '',
      backgroundColor: Theme.of(context).colorScheme.background,
      selectedIconBox: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      selectedIconColor: Theme.of(context).colorScheme.primary,
      selectedTextColor: Theme.of(context).colorScheme.inversePrimary,
      unselectedIconColor: Theme.of(context).colorScheme.outline,
      unselectedTextColor: Theme.of(context).colorScheme.outline,
      textStyle: Theme.of(context).textTheme.bodyMedium,
      titleStyle: Theme.of(context).textTheme.headlineSmall,
      borderRadius: 4,
      screenPadding: 0,
      showToggleButton: false,
      maxWidth: 250,
      toggleTitleStyle:
          const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      sidebarBoxShadow: const [
        // Grey shadow
        BoxShadow(
          blurRadius: 10,
          spreadRadius: 1,
          offset: Offset(-12, 0),
        ),
      ],
    );
  }
}
