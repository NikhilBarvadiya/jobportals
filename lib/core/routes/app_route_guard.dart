import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobportals/core/routes/app_route_names.dart';
import 'package:jobportals/view/auth/auth_service.dart';

class RouteGuard extends GetMiddleware {
  final authService = Get.find<AuthService>();

  @override
  RouteSettings? redirect(String? route) {
    return authService.isUserLoggedIn.value ? null : const RouteSettings(name: AppRouteNames.auth);
  }
}
