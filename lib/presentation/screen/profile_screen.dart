import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value!;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Theme.of(context).primaryColor, width: 4),
              ),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(user.profileImageUrl),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              user.email,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user.name,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(width: 8),
                /*IconButton(
                  icon: const Icon(Icons.edit, color: Colors.orange),
                  onPressed: () {
                    _showEditNameDialog(context, ref, user.name);
                  },
                ),*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}