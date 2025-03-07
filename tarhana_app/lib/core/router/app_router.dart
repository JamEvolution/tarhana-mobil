import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tarhana_app/features/auth/presentation/pages/login_page.dart';
import 'package:tarhana_app/features/auth/presentation/pages/register_page.dart';
import 'package:tarhana_app/features/home/presentation/pages/add_tarhana_page.dart';
import 'package:tarhana_app/features/home/presentation/pages/home_page.dart';
import 'package:tarhana_app/features/profile/presentation/pages/profile_page.dart';
import 'package:tarhana_app/features/settings/presentation/pages/settings_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: LoginRoute.page,
          path: '/login',
        ),
        AutoRoute(
          page: RegisterRoute.page,
          path: '/register',
        ),
        AutoRoute(
          page: HomeRoute.page,
          path: '/',
          initial: true,
        ),
        AutoRoute(
          page: ProfileRoute.page,
          path: '/profile',
        ),
        AutoRoute(
          page: SettingsRoute.page,
          path: '/settings',
        ),
        AutoRoute(
          page: AddTarhanaRoute.page,
          path: '/add-tarhana',
        ),
      ];
} 