import 'dart:io';
import 'package:flutter/material.dart';
import 'package:soundcircle/createAccount.dart';
import 'package:soundcircle/feed.dart';
import 'package:soundcircle/gradientText.dart';
import 'package:soundcircle/loginPage.dart';
import 'package:image_picker/image_picker.dart';

class additionalDataPage extends StatefulWidget {
  const additionalDataPage({super.key});

  @override
  State<additionalDataPage> createState() => _additionalDataPageState();
}

class _additionalDataPageState extends State<additionalDataPage> {
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
                const SizedBox(height: 30),
                imageProfile(),
                const SizedBox(height: 15),
                const Text('Profile Picture'),
                const SizedBox(height: 60), // Add spacing between widgets
                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)
                      ),
                      hintText: 'Enter your spotify username',
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
                                  builder: (_) => createAccountPage()));
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
                                  builder: (_) => feed()));
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
          radius: 60,
          backgroundImage: _imageFile==null? AssetImage("assets/profileImage.png"): FileImage(File(_imageFile!.path)) as ImageProvider,
        ),
        Positioned(
            bottom: 1,
            right: 8,
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
                  size: 30
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
