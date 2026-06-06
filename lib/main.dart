import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'Age_Calculator/core/theme/app_theme.dart';
import 'Age_Calculator/core/theme/theme_provider.dart';
import 'Age_Calculator/features/age_Calculator/provider/age_provider.dart';
import 'Age_Calculator/features/age_Calculator/presentation/navigation/bottom_nav_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      child: const BottomNavScreen(),
    ),
  );
}