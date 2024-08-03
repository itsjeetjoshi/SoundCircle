import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(150,50)),
                  backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
                  shadowColor: MaterialStateProperty.all(Colors.black),
                ),
                onPressed: null,
                child: const Text(
                  "Email-Id",
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  const GradientText(
      this.text, {
        required this.gradient,
        required this.style,
      });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: style.copyWith(color: Colors.white),
      ),
    );
  }
}
/*Container(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFa8c0ff),
              Color(0xFF3f2b96),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 150), // Add top margin
              const SizedBox(
                height: 100,
                child: Text(
                  "Log-in With",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3f2b96),
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
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(150,50)),
                  backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
                  shadowColor: MaterialStateProperty.all(Colors.black),
                ),
                onPressed: null,
                child: const Text(
                    "Email-Id",
                  style: TextStyle(
                    color: Colors.black
                  ),
                ),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
 */
/*Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Login with page.png'),
            //fit: BoxFit.cover
          )
        ),
      ),*/