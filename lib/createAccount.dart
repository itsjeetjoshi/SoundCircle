import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:soundcircle/additionalData.dart';
import 'package:soundcircle/gradientText.dart';
import 'package:soundcircle/loginPage.dart';
import 'package:http/http.dart' as http;

class createAccountPage extends StatefulWidget {
  const createAccountPage({super.key});

  @override
  State<createAccountPage> createState() => _createAccountPageState();
}

class _createAccountPageState extends State<createAccountPage> {
  final List<String> genders = ['Male', 'Female'];
  TextEditingController userNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneNoController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  String? selectedGender;
  void sendData(String username, String email, String  phoneNo, String age, String gender) async{
    try {
      final url = Uri.parse('http://192.168.29.101:3000/createUser');
      Map<String, dynamic> requestBody = {
        'username': username,
        'email': email,
        'phoneNo': phoneNo,
        'age': age,
        'gender': gender,
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
          print('Request was successful: ${response.body}');
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
                const SizedBox(height: 30), // Add top margin
                const SizedBox(
                  height: 50,
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
                    controller: userNameController,
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
                    controller: phoneNoController,
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
                    controller: emailController,
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
                    controller: ageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)
                      ),
                      hintText: 'Enter your age',
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Add spacing between widgets
                SizedBox(
                  width: 300,
                  child: DropdownButtonFormField<String>(
                    value: selectedGender, // The selected gender
                    hint: Text('Select Gender'),
                    items: genders.map((String gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedGender = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Color(0xFF494f66))
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                  builder: (_) => loginPage()));
                            },
                            child: Text("Back",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w300
                              ),))
                    ),
                    SizedBox(width: 25),
                    SizedBox(
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Color(0xFF494f66))
                            ),
                            onPressed: () {
                              print(userNameController.text + '' + emailController.text + '' + phoneNoController.text + '' + ageController.text);
                              sendData(userNameController.text, emailController.text, phoneNoController.text, ageController.text, selectedGender!);
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                  builder: (_) => additionalDataPage(phoneNo: phoneNoController.text)));
                            },
                            child: Text("Next",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w300
                              ),))
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}
