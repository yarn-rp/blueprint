import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationPageData {
  NavigationPageData({
    required this.text,
    required this.icon,
    required this.page,
  });

  final String text;
  final IconData icon;
  final Widget page;
}

// An scaffold with a material side bar with the navigation options in case
// is not in mobile. If mobile, then is a bottom app bar with the navigation
// options.
class InitialPage extends StatefulWidget {
  const InitialPage({super.key, required this.navigationPages});
  final List<NavigationPageData> navigationPages;

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final _key = GlobalKey<ScaffoldState>();
  late int currentIndex;
  @override
  void initState() {
    currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final isSmallScreen = MediaQuery.of(context).size.width < 800;
        return Theme(
          data: Theme.of(context).copyWith(
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: const Color(0xFF121212),
              unselectedItemColor: Colors.white54,
              selectedItemColor: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: Scaffold(
            bottomNavigationBar: isSmallScreen
                ? BottomNavigationBar(
                    currentIndex: currentIndex,
                    onTap: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    items: widget.navigationPages
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
            appBar: AppBar(
              actions: [
                // Settings
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.notifications,
                ),
                const SizedBox(width: 8),
                // Profile
                IconButton(
                  icon: const Icon(Icons.person),
                  onPressed: () {},
                ),
              ],
              centerTitle: true,
              title: Container(
                constraints: const BoxConstraints(
                  maxWidth: 600,
                ),
                child: const CupertinoSearchTextField(),
              ),
            ),
            body: isSmallScreen
                ? widget.navigationPages[currentIndex].page
                : SidebarPage(
                    navigationPages: widget.navigationPages,
                    initialPage: currentIndex,
                  ),
          ),
        );
      },
    );
  }
}

class SidebarPage extends StatefulWidget {
  const SidebarPage({
    super.key,
    required this.navigationPages,
    required this.initialPage,
  });
  final List<NavigationPageData> navigationPages;
  final int initialPage;

  @override
  _SidebarPageState createState() => _SidebarPageState();
}

class _SidebarPageState extends State<SidebarPage> {
  late int currentPage;

  @override
  void initState() {
    super.initState();

    currentPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;
    return CollapsibleSidebar(
      isCollapsed: isMobile,
      items: widget.navigationPages
          .map(
            (e) => CollapsibleItem(
              text: e.text,
              icon: e.icon,
              isSelected: widget.navigationPages.indexOf(e) == currentPage,
              onPressed: () => setState(() {
                currentPage = widget.navigationPages.indexOf(e);
              }),
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
          Expanded(child: widget.navigationPages[currentPage].page),
        ],
      ),
      title: 'Yan Rodriguez',
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
