import 'dart:ui';
import 'package:flutter/material.dart';
import 'gradientText.dart'; // Assuming you're reusing the GradientText
import 'artistSelection.dart'; // New page for artist selection

class favouriteGenres extends StatefulWidget {
  const favouriteGenres({super.key});

  @override
  State<favouriteGenres> createState() => _favouriteGenresState();
}

class _favouriteGenresState extends State<favouriteGenres> {
  List<int> _selectedGenres = []; // List to track selected genres

  List<String> genres = [
    'Rock',
    'Pop',
    'Hip-Hop',
    'Jazz',
    'Classical',
    'Electronic',
  ];

  void _selectGenre(int index) {
    setState(() {
      if (_selectedGenres.contains(index)) {
        _selectedGenres.remove(index);
      } else if (_selectedGenres.length < 3) {
        _selectedGenres.add(index);
      } else {
        // SnackBar to notify user when the limit is reached
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You can only select up to 3 genres.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  void _navigateToArtistSelection() {
    // Passing the selected genres to the next page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArtistSelection(
          selectedGenres: _selectedGenres.map((index) => genres[index]).toList(),
        ),
      ),
    );
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
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.5, // Adjust aspect ratio for card height
                      ),
                      itemCount: genres.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            _selectGenre(index);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white.withOpacity(0.1),
                              border: Border.all(
                                color: _selectedGenres.contains(index)
                                    ? Colors.green
                                    : Colors.transparent,
                                width: 2,
                              ),
                              boxShadow: _selectedGenres.contains(index)
                                  ? [
                                BoxShadow(
                                  color: Colors.green.withOpacity(0.5),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                                  : [],
                            ),
                            child: Center(
                              child: Text(
                                genres[index],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _selectedGenres.isNotEmpty
                        ? _navigateToArtistSelection
                        : null,
                    child: const Text('Confirm Selection'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
