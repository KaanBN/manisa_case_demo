import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manisa_case/presentation/screen/chat_details_screen.dart';
import 'package:manisa_case/presentation/screen/chats_screen.dart';
import 'package:manisa_case/presentation/screen/main_screen.dart';
import 'package:manisa_case/presentation/screen/profile_screen.dart';
import 'package:manisa_case/presentation/screen/settings_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/chats',
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainScreen(child: child),
      routes: [
        GoRoute(path: '/chats', builder: (context, state) => const ChatsScreen()),
        GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
        GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
      ],
    ),
    GoRoute(
      path: '/chat_detail/:id',
      builder: (context, state) {
        final chatId = int.parse(state.pathParameters['id']!);
        return ChatDetailScreen(chatId: chatId);
      },
    ),
  ],
);