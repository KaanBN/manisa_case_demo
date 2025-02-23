import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),

            SvgPicture.asset(
              "assets/images/chat.svg",
              width: 120,
              height: 120,
            ),

            const SizedBox(height: 30),

            Text(
              "Mesajlaşmaya başlayın",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 10),

            Text(
              "Sürekli iletişimde olun. İletişim önemlidir",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  context.push('/register');
                },
                child: const Text(
                  "Kayıt olun",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            TextButton(
              onPressed: () {
                context.push('/login');
              },
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: 'Hesabınız var mı ? ', style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                    TextSpan(text: 'Giriş yap', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                  ]
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
