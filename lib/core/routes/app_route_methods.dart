import 'package:get/get.dart';
import 'package:jobportals/core/routes/app_route_guard.dart';
import 'package:jobportals/core/routes/app_route_names.dart';
import 'package:jobportals/view/auth/auth.dart';
import 'package:jobportals/view/home/home.dart';
import 'package:jobportals/view/no_internet.dart';
import 'package:jobportals/view/permission/permission.dart';
import 'package:jobportals/view/splash/splash.dart';

class AppRouteMethods {
  static GetPage<dynamic> getPage({required String name, required GetPageBuilder page, List<GetMiddleware>? middlewares}) {
    return GetPage(
      name: name,
      page: page,
      transition: Transition.topLevel,
      showCupertinoParallax: true,
      middlewares: middlewares ?? [],
      transitionDuration: 350.milliseconds,
    );
  }

  static List<GetPage> pages = [
    getPage(name: AppRouteNames.splash, page: () => const SplashView()),
    getPage(name: AppRouteNames.prominent, page: () => const PermissionView()),
    getPage(name: AppRouteNames.auth, page: () => const AuthView()),
    getPage(name: AppRouteNames.home, middlewares: [RouteGuard()], page: () => const HomeView()),
    getPage(name: AppRouteNames.noInternet, page: () => const NoInternetScreen()),
  ];
}
