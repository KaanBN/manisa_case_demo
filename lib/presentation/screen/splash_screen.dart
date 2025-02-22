import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:manisa_case/presentation/providers/auth_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authProvider, (previous, next) {
      next.when(
        data: (user) {
          if (user != null) {
            context.go('/chats');
          } else {
            context.go('/onboarding');
          }
        },
        loading: () {},
        error: (err, _) => context.go('/settings'),
      );
    });

    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}