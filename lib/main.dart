import 'package:dalak_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dalak_app/providers/LoginFormProvider.dart';
import 'package:dalak_app/providers/SignupFormProvider.dart';
import 'package:dalak_app/utils/theme.dart';
import 'package:dalak_app/router/router.dart';
import 'package:dalak_app/providers/ThemeProvider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => ThemeProvider(prefs: prefs)),
        ChangeNotifierProvider(create: (context) => LoginFormProvider()),
        ChangeNotifierProvider(create: (context) => SignupFormProvider()),
      ],
      child: Builder(
        builder: (context) {
          final selectedTheme = Provider.of<ThemeProvider>(context).theme;
          return MaterialApp.router(
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: selectedTheme == 'system'
                ? ThemeMode.system
                : selectedTheme == 'dark'
                    ? ThemeMode.dark
                    : ThemeMode.light,
          );
        },
      ),
    ),
  );
}
