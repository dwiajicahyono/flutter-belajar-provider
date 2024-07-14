import 'package:flutter/material.dart';
import 'screens/cat_fact_screen.dart';
import 'providers/providers.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  final envPath = '.env';
  await dotenv.load(fileName: envPath);
  runApp(
    Providers(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CatFactScreen(),
    );
  }
}
