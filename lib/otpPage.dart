import 'package:flutter/material.dart';
import 'package:soundcircle/gradientText.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class otpPage extends StatefulWidget {
  const otpPage({super.key});

  @override
  State<otpPage> createState() => _otpPageState();
}

class _otpPageState extends State<otpPage> {
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
              borderRadius:   BorderRadius.all(Radius.circular(10.0)),
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,
              //runs when a code is typed in
              onCodeChanged: (String code) {
                //handle validation or checks here
              },
              //runs when every textfield is filled
              onSubmit: (String verificationCode){
                showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: Text("Verification Code"),
                        content: Text('Code entered is $verificationCode'),
                      );
                    }
                );
              }, // end onSubmit
            ),
            const SizedBox(height: 40),
            SizedBox(
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF494f66))
                    ),
                    onPressed: (){
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(builder: (_) => otpPage()));
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
