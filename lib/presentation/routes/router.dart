import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hello_ddd/presentation/pages/role_page/role_selection_page.dart';
import 'package:hello_ddd/presentation/pages/sign_in/sign_in_page.dart';
import 'package:hello_ddd/presentation/pages/splash/splash_page.dart';
import 'package:hello_ddd/presentation/pages/work_task_form/work_task_form_page.dart';
import 'package:hello_ddd/presentation/pages/work_tasks_overview/work_tasks_overview_page.dart';

import 'package:hello_ddd/domain/work_tasks/work_task.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SignInRoute.page, path: '/sign_in_page'),
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: WorkTasksOverviewRoute.page),
        AutoRoute(page: WorkTaskFormRoute.page, fullscreenDialog: true),
        AutoRoute(page: RoleSelectionRoute.page),
      ];
}
