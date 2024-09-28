import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:soundcircle/createAccount.dart';
import 'package:soundcircle/favouriteGenres.dart';
import 'package:soundcircle/gradientText.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';

class additionalDataPage extends StatefulWidget {
  final String phoneNo;
  const additionalDataPage({super.key, required this.phoneNo});

  @override
  State<additionalDataPage> createState() => _additionalDataPageState();
}

class _additionalDataPageState extends State<additionalDataPage> {

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
                const SizedBox(height: 50),
                imageProfile(),
                const SizedBox(height: 25),
                const Text('Select a Profile Picture', style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),),
                SizedBox(height: 60),
                SizedBox(
                  width: 300,
                  child: TextField(
                    //controller: phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      hintText: 'Enter your username for Instagram',
                    ),
                  ),
                ),
                const SizedBox(height: 50),
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
                                  builder: (_) => favouriteGenres(currentUserId: currentUserId)));
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
