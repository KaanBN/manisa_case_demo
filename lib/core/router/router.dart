import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manisa_case/domain/entities/chat.dart';
import 'package:manisa_case/presentation/screen/auth/login_screen.dart';
import 'package:manisa_case/presentation/screen/auth/onboarding_screen.dart';
import 'package:manisa_case/presentation/screen/auth/register_screen.dart';
import 'package:manisa_case/presentation/screen/chat_details_screen.dart';
import 'package:manisa_case/presentation/screen/chats_screen.dart';
import 'package:manisa_case/presentation/screen/main_screen.dart';
import 'package:manisa_case/presentation/screen/profile_screen.dart';
import 'package:manisa_case/presentation/screen/settings_screen.dart';
import 'package:manisa_case/presentation/screen/splash_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/splash',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(),
    ),

    ShellRoute(
      builder: (context, state, child) => MainScreen(child: child),
      routes: [
        GoRoute(
            path: '/chats',
            builder: (context, state) => ChatsScreen()
        ),
        GoRoute(
            path: '/profile',
            builder: (context, state) => ProfileScreen()
        ),
        GoRoute(
            path: '/settings',
            builder: (context, state) => SettingsScreen()
        ),
      ],
    ),
    GoRoute(
      path: '/chat_detail/:id',
      builder: (context, state) {
        final chatId = int.parse(state.pathParameters['id']!);
        final chat = state.extra as Chat;
        return ChatDetailScreen(chatId: chatId, userName: chat.otherUser.username, userProfileUrl: chat.otherUser.profileImage.imageUrl,);
      },
    ),
  ],
);