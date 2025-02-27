import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_theme/json_theme.dart';
import 'package:manisa_case/core/router/router.dart';

Future<Map<String, ThemeData>> combineThemes() async {
  final lightThemeStr = await rootBundle.loadString('assets/json/appainter_theme.json');
  final darkThemeStr = await rootBundle.loadString('assets/json/appainter_theme_dark.json');

  final lightThemeJson = json.decode(lightThemeStr);
  final darkThemeJson = json.decode(darkThemeStr);

  final lightTheme = ThemeDecoder.decodeThemeData(lightThemeJson)!;
  final darkTheme = ThemeDecoder.decodeThemeData(darkThemeJson)!;

  return {'light': lightTheme, 'dark': darkTheme};
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  final combinedTheme = await combineThemes();

  runApp(ProviderScope(child: MyApp(
    lightTheme: combinedTheme['light']!,
    darkTheme: combinedTheme['dark']!,
  )));
}

class MyApp extends StatelessWidget {
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  const MyApp({
    super.key,
    required this.lightTheme,
    required this.darkTheme
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}