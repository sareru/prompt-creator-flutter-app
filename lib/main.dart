import 'package:flutter/material.dart';
import 'package:prompt_creator_flutter_app/gui/prompt.dart';
import 'package:prompt_creator_flutter_app/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appThemeLight,
      darkTheme: appThemeDark,
      home: Scaffold(body: PromptCreator()),
    );
  }
}
