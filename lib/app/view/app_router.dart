import 'package:auto_route/auto_route.dart';
import 'package:blueprint/app/app.dart';
import 'package:blueprint/blueprint/presentation/pages/todays_blueprint.dart';
import 'package:blueprint/integrations/presentation/pages/integrations_page.dart';
import 'package:blueprint/settings/presentation/pages/settings_page.dart';
import 'package:blueprint/tasks/presentation/pages/tasks_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(
          page: SettingsRoute.page,
          path: '/settings',
        ),
        AutoRoute(
          page: IntegrationsRoute.page,
          path: '/settings/integrations',
        ),
        AutoRoute(
          path: '/',
          page: InitialRoute.page,
          children: [
            AutoRoute(
              path: 'todays-blueprint',
              page: TodaysBlueprintRoute.page,
            ),
            AutoRoute(
              path: 'might-do',
              page: TasksRoute.page,
            ),
          ],
        )
      ];
}
