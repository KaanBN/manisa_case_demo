import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:manisa_case/presentation/providers/auth_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Center(
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: (){
                final authNotifier = ref.read(authProvider.notifier);
                authNotifier.logout();
                final authState = ref.read(authProvider);
                authState.whenData((user){
                  if(user == null){
                    context.go('/onboarding');
                  }
                });
              },
              child: Text(
                "Çıkış Yap",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary),
              ),
            );
          },
        )
      ),
    );
  }
}
