// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [BlueprintRouterPage]
class BlueprintRouterRoute extends PageRouteInfo<void> {
  const BlueprintRouterRoute({List<PageRouteInfo>? children})
      : super(
          BlueprintRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'BlueprintRouterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BlueprintRouterPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CreateBlueprintPage();
    },
  );
}

/// generated route for
/// [ForgotPasswordPage]
class ForgotPasswordRoute extends PageRouteInfo<ForgotPasswordRouteArgs> {
  ForgotPasswordRoute({
    required AuthenticationResultFunction onResult,
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ForgotPasswordRouteArgs>();
      return ForgotPasswordPage(
        onResult: args.onResult,
        key: args.key,
      );
    },
  );
}

class ForgotPasswordRouteArgs {
  const ForgotPasswordRouteArgs({
    required this.onResult,
    this.key,
  });

  final AuthenticationResultFunction onResult;

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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const InitialPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final queryParams = data.queryParams;
      final args = data.argsAs<IntegrateWithPlatformRouteArgs>(
          orElse: () => IntegrateWithPlatformRouteArgs(
                platformId: pathParams.getString('platformId'),
                code: queryParams.optString('code'),
              ));
      return IntegrateWithPlatformPage(
        platformId: args.platformId,
        code: args.code,
        key: args.key,
      );
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const IntegrationsPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsPage();
    },
  );
}

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<SignInRouteArgs> {
  SignInRoute({
    required AuthenticationResultFunction onResult,
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignInRouteArgs>();
      return SignInPage(
        onResult: args.onResult,
        key: args.key,
      );
    },
  );
}

class SignInRouteArgs {
  const SignInRouteArgs({
    required this.onResult,
    this.key,
  });

  final AuthenticationResultFunction onResult;

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
    required AuthenticationResultFunction onResult,
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignUpRouteArgs>();
      return SignUpPage(
        onResult: args.onResult,
        key: args.key,
      );
    },
  );
}

class SignUpRouteArgs {
  const SignUpRouteArgs({
    required this.onResult,
    this.key,
  });

  final AuthenticationResultFunction onResult;

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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TasksPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TodaysBlueprintPage();
    },
  );
}
