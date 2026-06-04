import 'package:flutter/material.dart';
import 'package:flutter_w/Age_Calculator/features/age_Calculator/provider/age_provider.dart';
import 'package:provider/provider.dart';


import 'Age_Calculator/core/theme/app_theme.dart';
import 'Age_Calculator/core/theme/theme_provider.dart';

import 'Age_Calculator/features/age_Calculator/presentation/navigation/bottom_nav_screen.dart';

void main() async {
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AgeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final theme = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: theme.themeMode,

      home: const BottomNavScreen(),
    );
  }
}