import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:soundcircle/createAccount.dart';
import 'package:soundcircle/otpPage.dart';
import 'gradientText.dart';
import 'package:firebase_auth/firebase_auth.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  TextEditingController phoneController = new TextEditingController();

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
            colors: [Color(0xFF7185c1), Color(0xFF494f66), Color(0xFF292347)],
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
                    Color(0xFFa4bbfb), // Your end color
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 100), // Add top margin
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
                  controller: phoneController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    hintText: 'Enter your mobile number',
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF494f66))),
                      onPressed: () async {
                        await FirebaseAuth.instance.verifyPhoneNumber(
                            verificationCompleted:
                                (PhoneAuthCredential credential) {},
                            verificationFailed: (FirebaseAuthException e) {},
                            codeSent:
                                (String verificationId, int? recentToken) {
                              log("ok");
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (_) => otpPage(verificationId: verificationId, phoneNo: phoneController.text)));
                                },
                            codeAutoRetrievalTimeout:
                                (String verificationId) {},
                            phoneNumber: phoneController.text.toString());
                      },
                      child: Text(
                        "Get OTP",
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.w300),
                      ))),
              const SizedBox(height: 40), // Add spacing between widgets
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (_) => createAccountPage()));
                      },
                      child: Text(
                        "Create One",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black54),
                      ))
                ],
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
