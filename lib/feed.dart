import 'package:flutter/material.dart';

import 'gradientText.dart';

class feed extends StatefulWidget {
  const feed({super.key});

  @override
  State<feed> createState() => _feedState();
}

class _feedState extends State<feed> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF7185c1),
                  Color(0xFF494f66),
                  Color(0xFF292347)
                ],
              ),
            ),
            child: const Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                  const SizedBox(height: 30),
              const GradientText(
                'SoundCircle',
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF43309a), // Your start color
                    Color(0xFF7477cc),
                    Color(0xFFa4bbfb), // Your end color
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400),
              ),]))
        )
    );
  }
}
