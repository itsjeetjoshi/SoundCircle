import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soundcircle/gradientText.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:soundcircle/loginPage.dart';
import 'feed.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class otpPage extends StatefulWidget {
  String verificationId;
  final String phoneNo;
  otpPage({super.key, required this.verificationId, required this.phoneNo});

  @override
  State<otpPage> createState() => _otpPageState();
}

class _otpPageState extends State<otpPage> {

  List<dynamic> jsonResponse = [];
  int currentUserId = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final url = Uri.parse('http://169.254.164.116:3000/getCurrentUserId');
      print(widget.phoneNo);
      Map<String, dynamic> requestBody = {
        'phoneNo': widget.phoneNo
      };
      try {
        // Send the POST request
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',  // Specify the content type if sending JSON
          },
          body: json.encode(requestBody),  // Encode the body as JSON
        );
        // Check the response status
        if (response.statusCode == 200) {
          setState(() {
            jsonResponse = jsonDecode(response.body);
            currentUserId = jsonResponse[0]['userId'];
            print(currentUserId);
          });
          print('Request was successful');
        } else {
          print('Failed with status: ${response.statusCode}');
        }
      } catch (error) {
        print('Error occurred: $error');
      }
    } catch (e) {
      print('Error: $e');
    }
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
            const SizedBox(height: 100), // Add top margin
            const SizedBox(
              height: 100,
              child: Text(
                "Enter OTP",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1f2035),
                ),
              ),
            ),
            const SizedBox(height: 30),
            OtpTextField(
                numberOfFields: 6,
                borderColor: Color(0xFF292347),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //set to true to show as box or false to show as dash
                showFieldAsBox: true,
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode) async {
                  try {
                    PhoneAuthCredential credential =
                        await PhoneAuthProvider.credential(
                            verificationId: widget.verificationId,
                            smsCode: verificationCode);
                    FirebaseAuth.instance.signInWithCredential(credential).then((value){
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => feed(currentUserId: currentUserId, phoneNo: '')
                          ));});
                  } catch (e) {
                    log(e.toString());
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => loginPage()));
                  }
                }),
          ],
        ),
      ),
    ));
  }
}
