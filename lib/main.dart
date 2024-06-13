import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dalak/providers/LoginFormProvider.dart';
import 'package:dalak/providers/SignupFormProvider.dart';
import 'package:dalak/utils/theme.dart';
import 'package:dalak/router/router.dart';
import 'package:dalak/providers/ThemeProvider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
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
          final _selectedTheme = Provider.of<ThemeProvider>(context).theme;
          return MaterialApp.router(
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: _selectedTheme == 'system'
                ? ThemeMode.system
                : _selectedTheme == 'dark'
                    ? ThemeMode.dark
                    : ThemeMode.light,
          );
        },
      ),
    ),
  );
}
