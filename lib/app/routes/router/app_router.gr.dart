// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    BlueprintRouterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BlueprintRouterPage(),
      );
    },
    CreateBlueprintRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateBlueprintPage(),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ForgotPasswordRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ForgotPasswordPage(
          onResult: args.onResult,
          key: args.key,
        ),
      );
    },
    InitialRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const InitialPage(),
      );
    },
    IntegrateWithPlatformRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<IntegrateWithPlatformRouteArgs>(
          orElse: () => IntegrateWithPlatformRouteArgs(
                platformId: pathParams.getString('platformId'),
                code: queryParams.optString('code'),
              ));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: IntegrateWithPlatformPage(
          platformId: args.platformId,
          code: args.code,
          key: args.key,
        ),
      );
    },
    IntegrationsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const IntegrationsPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsPage(),
      );
    },
    SignInRoute.name: (routeData) {
      final args = routeData.argsAs<SignInRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SignInPage(
          onResult: args.onResult,
          key: args.key,
        ),
      );
    },
    SignUpRoute.name: (routeData) {
      final args = routeData.argsAs<SignUpRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SignUpPage(
          onResult: args.onResult,
          key: args.key,
        ),
      );
    },
    TasksRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TasksPage(),
      );
    },
    TodaysBlueprintRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TodaysBlueprintPage(),
      );
    },
  };
}

/// generated route for
/// [BlueprintRouterPage]
class BlueprintRouterRoute extends PageRouteInfo<void> {
  const BlueprintRouterRoute({List<PageRouteInfo>? children})
      : super(
          BlueprintRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'BlueprintRouterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CreateBlueprintPage]
class CreateBlueprintRoute extends PageRouteInfo<void> {
  const CreateBlueprintRoute({List<PageRouteInfo>? children})
      : super(
          CreateBlueprintRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateBlueprintRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ForgotPasswordPage]
class ForgotPasswordRoute extends PageRouteInfo<ForgotPasswordRouteArgs> {
  ForgotPasswordRoute({
    required void Function({bool? result}) onResult,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ForgotPasswordRoute.name,
          args: ForgotPasswordRouteArgs(
            onResult: onResult,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

  static const PageInfo<ForgotPasswordRouteArgs> page =
      PageInfo<ForgotPasswordRouteArgs>(name);
}

class ForgotPasswordRouteArgs {
  const ForgotPasswordRouteArgs({
    required this.onResult,
    this.key,
  });

  final void Function({bool? result}) onResult;

  final Key? key;

  @override
  String toString() {
    return 'ForgotPasswordRouteArgs{onResult: $onResult, key: $key}';
  }
}

/// generated route for
/// [InitialPage]
class InitialRoute extends PageRouteInfo<void> {
  const InitialRoute({List<PageRouteInfo>? children})
      : super(
          InitialRoute.name,
          initialChildren: children,
        );

  static const String name = 'InitialRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [IntegrateWithPlatformPage]
class IntegrateWithPlatformRoute
    extends PageRouteInfo<IntegrateWithPlatformRouteArgs> {
  IntegrateWithPlatformRoute({
    required String platformId,
    String? code,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          IntegrateWithPlatformRoute.name,
          args: IntegrateWithPlatformRouteArgs(
            platformId: platformId,
            code: code,
            key: key,
          ),
          rawPathParams: {'platformId': platformId},
          rawQueryParams: {'code': code},
          initialChildren: children,
        );

  static const String name = 'IntegrateWithPlatformRoute';

  static const PageInfo<IntegrateWithPlatformRouteArgs> page =
      PageInfo<IntegrateWithPlatformRouteArgs>(name);
}

class IntegrateWithPlatformRouteArgs {
  const IntegrateWithPlatformRouteArgs({
    required this.platformId,
    this.code,
    this.key,
  });

  final String platformId;

  final String? code;

  final Key? key;

  @override
  String toString() {
    return 'IntegrateWithPlatformRouteArgs{platformId: $platformId, code: $code, key: $key}';
  }
}

/// generated route for
/// [IntegrationsPage]
class IntegrationsRoute extends PageRouteInfo<void> {
  const IntegrationsRoute({List<PageRouteInfo>? children})
      : super(
          IntegrationsRoute.name,
          initialChildren: children,
        );

  static const String name = 'IntegrationsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<SignInRouteArgs> {
  SignInRoute({
    required void Function({bool? result}) onResult,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SignInRoute.name,
          args: SignInRouteArgs(
            onResult: onResult,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const PageInfo<SignInRouteArgs> page = PageInfo<SignInRouteArgs>(name);
}

class SignInRouteArgs {
  const SignInRouteArgs({
    required this.onResult,
    this.key,
  });

  final void Function({bool? result}) onResult;

  final Key? key;

  @override
  String toString() {
    return 'SignInRouteArgs{onResult: $onResult, key: $key}';
  }
}

/// generated route for
/// [SignUpPage]
class SignUpRoute extends PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({
    required void Function({bool? result}) onResult,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SignUpRoute.name,
          args: SignUpRouteArgs(
            onResult: onResult,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const PageInfo<SignUpRouteArgs> page = PageInfo<SignUpRouteArgs>(name);
}

class SignUpRouteArgs {
  const SignUpRouteArgs({
    required this.onResult,
    this.key,
  });

  final void Function({bool? result}) onResult;

  final Key? key;

  @override
  String toString() {
    return 'SignUpRouteArgs{onResult: $onResult, key: $key}';
  }
}

/// generated route for
/// [TasksPage]
class TasksRoute extends PageRouteInfo<void> {
  const TasksRoute({List<PageRouteInfo>? children})
      : super(
          TasksRoute.name,
          initialChildren: children,
        );

  static const String name = 'TasksRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TodaysBlueprintPage]
class TodaysBlueprintRoute extends PageRouteInfo<void> {
  const TodaysBlueprintRoute({List<PageRouteInfo>? children})
      : super(
          TodaysBlueprintRoute.name,
          initialChildren: children,
        );

  static const String name = 'TodaysBlueprintRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
