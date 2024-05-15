import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../domain/models/user.dart';
import '../screens/add_content/add_content_screen.dart';
import '../screens/authorization/login_screen.dart';
import '../screens/authorization/registration_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/profile/edit_profile_screen.dart';
import '../screens/profile/profile_screen.dart';
import 'guards/auth_guard.dart';
import 'navigators/bottom_navigator.dart';
import 'navigators/home_navigator.dart';

part 'navigation.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegistrationRoute.page),
        AutoRoute(page: EditProfileRoute.page),
        AutoRoute(page: AddContentRoute.page),
        AutoRoute(page: BottomNavigatorRoute.page, initial: true, children: [
          AutoRoute(page: HomeNavigatorRoute.page, children: [
            AutoRoute(initial: true, page: HomeRoute.page),
            AutoRoute(page: ProfileRoute.page),
          ]),
          AutoRoute(page: AddContentRoute.page),
          AutoRoute(page: ProfileRoute.page),
        ], guards: [
          AuthGuard(),
        ]),
      ];
}
