import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cat_fact_provider.dart';
import 'cat_image_provider.dart';


class Providers extends StatelessWidget {
  final Widget child;

  Providers({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CatFactProvider()),
        ChangeNotifierProvider(create: (context) => CatImageProvider()),
      ],
      child: child,
    );
  }
}
