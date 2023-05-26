import 'package:auto_route/annotations.dart';
import 'package:hello_ddd/presentation/pages/sign_in_page/sign_in_page.dart';
import 'package:hello_ddd/presentation/pages/splash/splash_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    // AutoRoute(
    //   page: SplashPage,
    //   initial: true,
    // ),
    MaterialRoute(
      page: SignInPage,
      path: '/sign_in_page',
    ),
    MaterialRoute(
      page: SplashPage,
      initial: true,
    ),
  ],
)
class $AppRouter {}
