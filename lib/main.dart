import 'package:flutter/material.dart';
import 'package:mobile/pages/measure_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          body: TestPage()),
    );
  }
}

class TestPage extends StatelessWidget {
  const TestPage({super.key});
  @override
  Widget build(BuildContext context) {
    /*
    return Scaffold(
      body: Center(
        child: Text("Observatoire du Climat"),
      ),
    );
     */
    return MeasurePage();
  }
}