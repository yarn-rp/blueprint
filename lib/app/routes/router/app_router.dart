import 'package:auto_route/auto_route.dart';
import 'package:blueprint/app/app.dart';
import 'package:blueprint/app/routes/guards/authentication_guard.dart';
import 'package:blueprint/authentication/presentation/pages/forgot_password_screen.dart';
import 'package:blueprint/authentication/presentation/pages/sign_in_page.dart';
import 'package:blueprint/authentication/presentation/pages/sign_up_page.dart';
import 'package:blueprint/authentication/state_management/authentication_cubit/authentication_cubit.dart';
import 'package:blueprint/blueprint/presentation/pages/create_blueprint_page.dart';
import 'package:blueprint/blueprint/presentation/pages/todays_blueprint.dart';
import 'package:blueprint/integrations/presentation/pages/integrate_with_platform_page.dart';
import 'package:blueprint/integrations/presentation/pages/integrations_page.dart';
import 'package:blueprint/settings/presentation/pages/settings_page.dart';
import 'package:blueprint/tasks/presentation/pages/tasks_page.dart';
import 'package:flutter/foundation.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  AppRouter({
    required AuthenticationCubit authenticationCubit,
  }) : authenticationGuard = AuthGuard(authenticationCubit);

  final AuthGuard authenticationGuard;
  @override
  List<AutoRoute> get routes => [
        /// Unauthenticated routes go here
        AutoRoute(
          page: SignInRoute.page,
          path: '/sign-in',
        ),
        AutoRoute(
          page: SignUpRoute.page,
          path: '/sign-up',
        ),
        AutoRoute(
          page: ForgotPasswordRoute.page,
          path: '/forgot-password',
        ),

        /// routes go here
        AutoRoute(
          page: SettingsRoute.page,
          path: '/settings',
          guards: [authenticationGuard],
        ),
        AutoRoute(
          page: IntegrationsRoute.page,
          path: '/settings/integrations',
          guards: [authenticationGuard],
        ),
        AutoRoute(
          path: '/integrations/:platformId/create',
          page: IntegrateWithPlatformRoute.page,
          guards: [authenticationGuard],
        ),
        AutoRoute(
          path: '/',
          page: InitialRoute.page,
          guards: [authenticationGuard],
          children: [
            AutoRoute(
              path: 'blueprint',
              page: BlueprintRouterRoute.page,
              children: [
                AutoRoute(
                  path: '',
                  page: TodaysBlueprintRoute.page,
                ),
                AutoRoute(
                  path: 'create',
                  page: CreateBlueprintRoute.page,
                ),
              ],
            ),
            AutoRoute(
              path: 'tasks',
              page: TasksRoute.page,
            ),
            AutoRoute(
              path: 'integrations',
              page: IntegrationsRoute.page,
            ),
          ],
        ),
      ];
}

@RoutePage()
class BlueprintRouterPage extends AutoRouter {
  const BlueprintRouterPage({super.key});
}
