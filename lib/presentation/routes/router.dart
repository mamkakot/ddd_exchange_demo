import 'package:auto_route/auto_route.dart';
import 'package:hello_ddd/presentation/pages/sign_in_page/sign_in_page.dart';
import 'package:hello_ddd/presentation/pages/splash/splash_page.dart';
import 'package:hello_ddd/presentation/pages/work_tasks/work_tasks_overview_page.dart';

part './router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SignInRoute.page, path: '/sign_in_page', initial: true),
        AutoRoute(page: SplashRoute.page),
        AutoRoute(page: WorkTasksOverviewRoute.page),
      ];
}
