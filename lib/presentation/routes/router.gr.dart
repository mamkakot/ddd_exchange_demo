// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    SignInRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignInPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashPage(),
      );
    },
    WorkTasksOverviewRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WorkTasksOverviewPage(),
      );
    },
    WorkTaskFormRoute.name: (routeData) {
      final args = routeData.argsAs<WorkTaskFormRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WorkTaskFormPage(
          key: args.key,
          editedWorkTask: args.editedWorkTask,
        ),
      );
    },
  };
}

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WorkTasksOverviewPage]
class WorkTasksOverviewRoute extends PageRouteInfo<void> {
  const WorkTasksOverviewRoute({List<PageRouteInfo>? children})
      : super(
          WorkTasksOverviewRoute.name,
          initialChildren: children,
        );

  static const String name = 'WorkTasksOverviewRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WorkTaskFormPage]
class WorkTaskFormRoute extends PageRouteInfo<WorkTaskFormRouteArgs> {
  WorkTaskFormRoute({
    Key? key,
    required WorkTask? editedWorkTask,
    List<PageRouteInfo>? children,
  }) : super(
          WorkTaskFormRoute.name,
          args: WorkTaskFormRouteArgs(
            key: key,
            editedWorkTask: editedWorkTask,
          ),
          initialChildren: children,
        );

  static const String name = 'WorkTaskFormRoute';

  static const PageInfo<WorkTaskFormRouteArgs> page =
      PageInfo<WorkTaskFormRouteArgs>(name);
}

class WorkTaskFormRouteArgs {
  const WorkTaskFormRouteArgs({
    this.key,
    required this.editedWorkTask,
  });

  final Key? key;

  final WorkTask? editedWorkTask;

  @override
  String toString() {
    return 'WorkTaskFormRouteArgs{key: $key, editedWorkTask: $editedWorkTask}';
  }
}
