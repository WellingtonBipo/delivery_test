import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DSTheme.of(context).colors.scaffoldBackground,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15).copyWith(
          bottom: 15 + DSBottonNavigator.overflowHeight(),
        ),
        child: Column(
          children: [
            for (var i = 0; i < 50; i++)
              Center(
                child: Text('$i ${DSTheme.of(context).platformBrightness}'),
              ),
          ],
        ),
      ),
      bottomNavigationBar: DSBottonNavigator(
        currentIndex: currentIndex,
        onChange: (index) => setState(() => currentIndex = index),
      ),
    );
  }
}
