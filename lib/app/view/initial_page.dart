// ignore_for_file: lines_longer_than_80_chars

import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:blueprint/app/dependency_injection/init.dart';
import 'package:blueprint/app/routes/routes.dart';
import 'package:blueprint/authentication/state_management/sign_out_cubit/sign_out_cubit.dart';
import 'package:blueprint/users/presentation/widgets/profile_menu.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:collection/collection.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final navigationPages = [
  NavigationPageData(
    text: 'Todays Blueprint',
    icon: Icons.today,
    route: const TodaysBlueprintRoute(),
  ),
  NavigationPageData(
    text: 'Tasks',
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
    currentIndex = 0;
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Builder(
        builder: (context) {
          final isPhone = MediaQuery.of(context).size.width < 600;

          return AutoTabsRouter(
            routes: const [
              BlueprintRouterRoute(),
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
                  trailing: Row(
                    children: [
                      BlocProvider(
                        create: (context) => sl<SignOutCubit>(),
                        child: const UserProfileView(),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          BetterFeedback.of(context)
                              .show((UserFeedback feedback) {
                            // Do something with the feedback
                          });
                        },
                        child: Text('Add Feedback'),
                      ),
                    ],
                  ),
                ),
                body: isPhone
                    ? child
                    : Row(
                        children: [
                          DesktopNavigationBar(
                            onDestinationSelected: tabsRouter.setActiveIndex,
                            destinations: navigationPages
                                .map(
                                  (e) => (label: e.text, icon: e.icon),
                                )
                                .toList(),
                          ),
                          Expanded(child: child),
                        ],
                      ),
              );
            },
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

// /// Flutter code sample for [Overlay].

// void main() => runApp(const OverlayApp());

// class OverlayApp extends StatelessWidget {
//   const OverlayApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: OverlayExample(),
//     );
//   }
// }

// class OverlayExample extends StatefulWidget {
//   const OverlayExample({super.key});

//   @override
//   State<OverlayExample> createState() => _OverlayExampleState();
// }

// class _OverlayExampleState extends State<OverlayExample> {
//   OverlayEntry? overlayEntry;
//   int currentPageIndex = 0;

//   void createHighlightOverlay({
//     required AlignmentDirectional alignment,
//     required Color borderColor,
//   }) {
//     // Remove the existing OverlayEntry.
//     removeHighlightOverlay();

//     assert(overlayEntry == null);

//     overlayEntry = OverlayEntry(
//       // Create a new OverlayEntry.
//       builder: (BuildContext context) {
//         // Align is used to position the highlight overlay
//         // relative to the NavigationBar destination.
//         return SafeArea(
//           child: Align(
//             alignment: alignment,
//             heightFactor: 1.0,
//             child: DefaultTextStyle(
//               style: const TextStyle(
//                 color: Colors.blue,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14.0,
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   const Text('Tap here for'),
//                   Builder(builder: (BuildContext context) {
//                     switch (currentPageIndex) {
//                       case 0:
//                         return const Column(
//                           children: <Widget>[
//                             Text(
//                               'Explore page',
//                               style: TextStyle(
//                                 color: Colors.red,
//                               ),
//                             ),
//                             Icon(
//                               Icons.arrow_downward,
//                               color: Colors.red,
//                             ),
//                           ],
//                         );
//                       case 1:
//                         return const Column(
//                           children: <Widget>[
//                             Text(
//                               'Commute page',
//                               style: TextStyle(
//                                 color: Colors.green,
//                               ),
//                             ),
//                             Icon(
//                               Icons.arrow_downward,
//                               color: Colors.green,
//                             ),
//                           ],
//                         );
//                       case 2:
//                         return const Column(
//                           children: <Widget>[
//                             Text(
//                               'Saved page',
//                               style: TextStyle(
//                                 color: Colors.orange,
//                               ),
//                             ),
//                             Icon(
//                               Icons.arrow_downward,
//                               color: Colors.orange,
//                             ),
//                           ],
//                         );
//                       default:
//                         return const Text('No page selected.');
//                     }
//                   }),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width / 3,
//                     height: 80.0,
//                     child: Center(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: borderColor,
//                             width: 4.0,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );

//     // Add the OverlayEntry to the Overlay.
//     Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
//   }

//   // Remove the OverlayEntry.
//   void removeHighlightOverlay() {
//     overlayEntry?.remove();
//     overlayEntry?.dispose();
//     overlayEntry = null;
//   }

//   @override
//   void dispose() {
//     // Make sure to remove OverlayEntry when the widget is disposed.
//     removeHighlightOverlay();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Overlay Sample'),
//       ),
//       bottomNavigationBar: NavigationBar(
//         selectedIndex: currentPageIndex,
//         destinations: const <NavigationDestination>[
//           NavigationDestination(
//             icon: Icon(Icons.explore),
//             label: 'Explore',
//           ),
//           NavigationDestination(
//             icon: Icon(Icons.commute),
//             label: 'Commute',
//           ),
//           NavigationDestination(
//             selectedIcon: Icon(Icons.bookmark),
//             icon: Icon(Icons.bookmark_border),
//             label: 'Saved',
//           ),
//         ],
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             'Use Overlay to highlight a NavigationBar destination',
//             style: Theme.of(context).textTheme.bodyMedium,
//           ),
//           const SizedBox(height: 20.0),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               // This creates a highlight Overlay for
//               // the Explore item.
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     currentPageIndex = 0;
//                   });
//                   createHighlightOverlay(
//                     alignment: AlignmentDirectional.bottomStart,
//                     borderColor: Colors.red,
//                   );
//                 },
//                 child: const Text('Explore'),
//               ),
//               const SizedBox(width: 20.0),
//               // This creates a highlight Overlay for
//               // the Commute item.
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     currentPageIndex = 1;
//                   });
//                   createHighlightOverlay(
//                     alignment: AlignmentDirectional.bottomCenter,
//                     borderColor: Colors.green,
//                   );
//                 },
//                 child: const Text('Commute'),
//               ),
//               const SizedBox(width: 20.0),
//               // This creates a highlight Overlay for
//               // the Saved item.
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     currentPageIndex = 2;
//                   });
//                   createHighlightOverlay(
//                     alignment: AlignmentDirectional.bottomEnd,
//                     borderColor: Colors.orange,
//                   );
//                 },
//                 child: const Text('Saved'),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10.0),
//           ElevatedButton(
//             onPressed: () {
//               removeHighlightOverlay();
//             },
//             child: const Text('Remove Overlay'),
//           ),
//         ],
//       ),
//     );
//   }
// }
