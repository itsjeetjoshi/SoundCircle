import 'dart:ui';
import 'package:flutter/material.dart';
import 'reusedComponents/profileCard.dart';
import 'gradientText.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class feed extends StatefulWidget {
  final int currentUserId;
  final String phoneNo;
  const feed({super.key, required this.currentUserId, required this.phoneNo});

  @override
  State<feed> createState() => _feedState();
}

class _feedState extends State<feed> {
  bool _showProfileCard = false;
  String _selectedUserName = '';
  int _selectedUserAge = 0; // To store the selected user's age
  List<dynamic> jsonResponse = [];
  String jsonLikeResponse = '';

  void _toggleProfileCard(String userName, int age) {
    setState(() {
      _showProfileCard = !_showProfileCard;
      _selectedUserName = userName;
      _selectedUserAge = age;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final url = Uri.parse('http://169.254.164.116:3000/getFeed');
      print(widget.currentUserId);
      Map<String, dynamic> requestBody = {
        'userId': widget.currentUserId
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
  Future<void> sendLike(int userId) async {
    try {
      final url = Uri.parse('http://169.254.164.116:3000/addLike');
      Map<String, dynamic> requestBody = {
        'userId': userId,
        'currentUserId': widget.currentUserId
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
            jsonLikeResponse = response.body;
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

  String getUsername(int index) {
    return jsonResponse[index]['userName'];
  }

  int getUserId(int index) {
    return jsonResponse[index]['userId'];
  }

  int getAge(int index) {
    return jsonResponse[index]['age'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF7185c1),
                  Color(0xFF494f66),
                  Color(0xFF292347),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  const GradientText(
                    'SoundCircle',
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF43309a),
                        Color(0xFF7477cc),
                        Color(0xFFa4bbfb),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: jsonResponse.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            _toggleProfileCard(getUsername(index), getAge(index));
                            print('Card $index tapped');
                          },
                          child: Card(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          getUsername(index),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Age ${getAge(index)}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'This is a short bio of the user. It gives a brief introduction.',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700],
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.thumb_up_alt),
                                    onPressed: () {
                                      sendLike(getUserId(index));
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      // Handle pass action
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_showProfileCard)
            buildOverlay(), // Pass the selected userName and age to the overlay
        ],
      ),
    );
  }

  Widget buildOverlay() {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 600,
        width: 300,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                _toggleProfileCard('', 0);
              },
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            Center(
              child: ProfileCard(
                userName: _selectedUserName,
                age: _selectedUserAge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
