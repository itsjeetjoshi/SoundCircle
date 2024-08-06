import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'gradientText.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //height: constraints.maxHeight,
        //width: constraints.maxWidth,
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
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
              ),
              const SizedBox(height: 150), // Add top margin
              const SizedBox(
                height: 100,
                child: Text(
                  "Log-in",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1f2035),
                  ),
                ),
              ),
              const SizedBox(height: 30), // Add spacing between widgets
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0)
                    ),
                    hintText: 'Enter your mobile number',
                  ),
                ),
              ),
              const SizedBox(height: 40), // Add spacing between widgets
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                  TextButton(onPressed: null, child: Text("Create One",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54
                    ),))
                ],
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}