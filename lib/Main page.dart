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
              const SizedBox(height: 40),
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
              const SizedBox(height: 150), // Add top margin
              const SizedBox(
                height: 100,
                child: Text(
                  "Log-in With",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1f2035),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Add spacing between widgets
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(75,50)),
                  backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
                  shadowColor: MaterialStateProperty.all(Colors.blueGrey),
                ),
                onPressed: null,
                child: const Text(
                  "Phone Number",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20), // Add spacing between widgets
              const Row(
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