import 'dart:async';

import 'package:flutter/material.dart';
import 'package:soundcircle/loginPage.dart';
import 'package:soundcircle/gradientText.dart';
import 'package:soundcircle/loginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      home: MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => loginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF7185c1), Color(0xFF494f66), Color(0xFF292347)],
            ),
          ),
          child: const Center(
            child: const GradientText(
              'SoundCircle',
              gradient: LinearGradient(
                colors: [
                  Color(0xFF43309a), // Your start color
                  Color(0xFF7477cc),
                  Color(0xFFa4bbfb),// Your end color
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400),
            ),
          ),
        )
    );
  }
}

