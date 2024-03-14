import 'package:flutter/material.dart';
import 'package:search_app/features/search/presentation/pages/search_page.dart';

void main() {
  //init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchPage(),
    );
  }
}
