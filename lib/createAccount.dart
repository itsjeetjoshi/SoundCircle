import 'package:flutter/material.dart';
import 'package:soundcircle/gradientText.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class createAccountPage extends StatefulWidget {
  const createAccountPage({super.key});

  @override
  State<createAccountPage> createState() => _createAccountPageState();
}

class _createAccountPageState extends State<createAccountPage> {
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
          child: Center(
            child: Column(
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
                ),
                const SizedBox(height: 40), // Add top margin
                const SizedBox(
                  height: 80,
                  child: Text(
                    "Create Account",
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
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)
                      ),
                      hintText: 'Enter your name',
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Add spacing between widgets
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
                const SizedBox(height: 20), // Add spacing between widgets
                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)
                      ),
                      hintText: 'Enter your email-id',
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Add spacing between widgets
                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)
                      ),
                      hintText: 'Enter your age',
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF494f66))
                        ),
                        onPressed: (){
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(builder: (_) => createAccountPage()));
                        },
                        child: Text("Submit",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w300
                          ),))
                ),
              ],
            ),
          ),
        ));
  }
}
