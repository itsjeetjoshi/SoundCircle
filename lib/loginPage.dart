import 'package:flutter/material.dart';
import 'package:soundcircle/gradientText.dart';

class mainPage extends StatefulWidget {
  const mainPage({super.key});


  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
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
              const SizedBox(height: 30),
              const GradientText(
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
              const SizedBox(height: 120), // Add top margin
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
              const SizedBox(height: 20), // Add spacing between widgets
              SizedBox(
                width: 300,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    hintText: 'Enter your mobile number',
                  ),
                ),
              ),
              const SizedBox(height: 40), // Add spacing between widgets
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(onPressed: null, child: Text("Create One"))
                ],
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}