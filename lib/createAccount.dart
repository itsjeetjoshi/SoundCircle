import 'dart:io';
import 'package:flutter/material.dart';
import 'package:soundcircle/gradientText.dart';
import 'package:soundcircle/loginPage.dart';
import 'package:image_picker/image_picker.dart';

class createAccountPage extends StatefulWidget {
  const createAccountPage({super.key});

  @override
  State<createAccountPage> createState() => _createAccountPageState();
}

class _createAccountPageState extends State<createAccountPage> {
  XFile? _imageFile = null;
  final ImagePicker _picker = ImagePicker();
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
                const SizedBox(height: 30),
                imageProfile(),
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
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                  builder: (_) => createAccountPage()));
                            },
                            child: Text("Submit",
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
  Widget imageProfile(){
    return Stack(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: _imageFile==null? AssetImage("assets/profileImage.png"): FileImage(File(_imageFile!.path)) as ImageProvider,
        ),
        Positioned(
            bottom: 1,
            right: 2,
            child: InkWell(
              onTap: (){
                showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheet())
                );
              },
              child: Icon(
                Icons.camera_alt,
                color: Colors.blueGrey,
                size: 20
              ),
            )
        )
      ],
    );
  }
  Widget bottomSheet(){
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Text(
              "Choose profile image",
            style: TextStyle(
              fontSize: 20.0
            ),
          ),
          TextButton.icon(
            icon: Icon(Icons.browse_gallery),
            onPressed: (){
              takePhoto(ImageSource.gallery);
            },
            label: Text("Gallery"),
          )
        ],
      ),
    );
  }
  void takePhoto(ImageSource source) async{
    final pickedFile = await _picker.pickImage(
        source: source
    );
    setState(() {
      _imageFile = pickedFile!;
    });
  }
}
