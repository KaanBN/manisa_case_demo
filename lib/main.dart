import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manisa_case/core/router/router.dart';
import 'package:manisa_case/core/theme/theme.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: GlobalTheme.lightTheme,
      darkTheme: GlobalTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}