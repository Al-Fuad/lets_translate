import 'package:flutter/material.dart';
import 'package:lets_translate/features/language_translation_screen.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Lets Translate',
      debugShowCheckedModeBanner: false,
      home: LanguageTranslationScreen(),
    );
  }
}
