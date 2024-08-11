import 'dart:ui';

import 'package:flutter/material.dart';
import 'reusedComponents/profileCard.dart';
import 'gradientText.dart';

class feed extends StatefulWidget {
  const feed({super.key});

  @override
  State<feed> createState() => _feedState();
}

class _feedState extends State<feed> {
  bool _showProfileCard = false;

  void _toggleProfileCard() {
    setState(() {
      _showProfileCard = !_showProfileCard;
    });
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
                      itemCount: 5, // Number of profile cards
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            _toggleProfileCard();
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
                                          'User ${index + 1}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Age ${20 + index}',
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
                                      // Handle like action
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
            buildOverlay(), // Display overlay if _showProfileCard is true
        ],
      ),
    );
  }

  Widget buildOverlay() {
    return Positioned.fill(
      child: Stack(
        children: [
          GestureDetector(
            onTap: _toggleProfileCard,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          Center(
            child: profileCard(),
          ),
        ],
      ),
    );
  }
}
