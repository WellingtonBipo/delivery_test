import 'package:delivery_test/app_providers.dart';
import 'package:delivery_test/views/app_routes.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: DSThemeProvider(
        builder: (context) {
          return MaterialApp(
            theme: DSTheme.of(context).themeData,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRoutes.onGenerateRoute,
          );
        },
      ),
    );
  }
}
