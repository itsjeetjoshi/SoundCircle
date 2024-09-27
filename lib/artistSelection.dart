import 'package:flutter/material.dart';
import 'package:soundcircle/feed.dart';
import 'gradientText.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ArtistSelection extends StatefulWidget {
  final List<String> selectedGenres;
  final int currentUserId;

  const ArtistSelection({super.key, required this.selectedGenres, required this.currentUserId});

  @override
  State<ArtistSelection> createState() => _ArtistSelectionState();
}

class _ArtistSelectionState extends State<ArtistSelection> {
  List<dynamic> jsonResponse = [];
  Map<String, List<String>> genreArtists = {
    'Rock': [
      'Queen', 'The Beatles', 'The Local Train', 'Farhan Akhtar', 'Strings',
      'Nirvana', 'Pink Floyd', 'Strings', 'Led Zeppelin', 'Kabir Cafe',
    ],
    'Pop': [
      'Michael Jackson', 'Lucky Ali', 'Ariana Grande', 'Dua Lipa', 'Bruno Mars',
      'Katy Perry', 'Celine Dion', 'Ed Sheeran', 'Adele', 'Palash Sen (Euphoria)',
    ],
    'Hip-Hop': [
      'Divine', 'Raftaar', 'Emiway Bantai', 'Krsna', 'Jay-Z',
      'Eminem', 'Kanye West', 'Drake', 'J. Cole', 'Ikka Singh',
    ],
    'Jazz': [
      'Louis Banks', 'Rickraj', 'Ranjit Barot', 'Sridhar Parthasarathy', 'Prasanna',
      'Duke Ellington', 'Miles Davis', 'Artist 8', 'Darshan Doshi', 'Rhythm Shaw',
    ],
    'Classical': [
      'Pandit Hariprasad Chaurasia', 'Ustad Zakir Hussain ', 'Pandit Ravi Shankar', 'Pandit Jasraj', 'Ludwig van Beethoven',
      'Wolfgang Amadeus Mozart', 'Johann Sebastian Bach', 'Franz Schubert', 'Richard Wagner', 'Nirali Karthik',
    ],
    'Bollywood': [
      'Amit Trivedi', 'Salim-Sulaiman', 'A.R Rahman', 'Arijit Singh', 'Sunidhi Chauhan',
      'R.D. Burman', 'Kishore Kumar', 'Shaan', 'Sonu Nigam', 'Shreya Ghoshal',
    ],
  };

  Map<String, List<int>> selectedArtists = {}; // To track selected artists per genre

  @override
  void initState() {
    super.initState();
    // Initialize selectedArtists map with empty lists
    for (var genre in widget.selectedGenres) {
      selectedArtists[genre] = [];
    }
  }

  void _selectArtist(String genre, int index) {
    setState(() {
      if (selectedArtists[genre]!.contains(index)) {
        selectedArtists[genre]!.remove(index);
      } else if (selectedArtists[genre]!.length < 3) {
        selectedArtists[genre]!.add(index);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You can only select up to 3 artists per genre.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  bool _isValidSelection() {
    // Ensure at least one artist is selected for each genre
    for (var genre in widget.selectedGenres) {
      if (selectedArtists[genre]!.isEmpty) {
        return false;
      }
    }
    return true;
  }

  void _onNextButtonPressed() {
    if (_isValidSelection()) {
      // Navigate to the next page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => feed(currentUserId: widget.currentUserId, phoneNo: "")), // Replace with your next page
      );
    } else {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one artist per genre.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> fetchData() async {
    try {
      final url = Uri.parse('http://192.168.29.101:3000/addGenreArtist');
      Map<String, dynamic> requestBody = {
        'userId': widget.currentUserId,
        'genres': widget.selectedGenres,
        'artists': selectedArtists
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.selectedGenres.length,
                      itemBuilder: (context, genreIndex) {
                        String genre = widget.selectedGenres[genreIndex];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$genre Artists',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 3,
                                ),
                                itemCount: genreArtists[genre]!.length,
                                itemBuilder: (context, artistIndex) {
                                  return GestureDetector(
                                    onTap: () {
                                      _selectArtist(genre, artistIndex);
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white.withOpacity(0.1),
                                        border: Border.all(
                                          color: selectedArtists[genre]!
                                              .contains(artistIndex)
                                              ? Colors.green
                                              : Colors.transparent,
                                          width: 2,
                                        ),
                                        boxShadow: selectedArtists[genre]!
                                            .contains(artistIndex)
                                            ? [
                                          BoxShadow(
                                            color: Colors.green
                                                .withOpacity(0.5),
                                            blurRadius: 10,
                                            spreadRadius: 1,
                                            offset: const Offset(0, 4),
                                          ),
                                        ]
                                            : [],
                                      ),
                                      child: Center(
                                        child: Text(
                                          genreArtists[genre]![artistIndex],
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: _isValidSelection() ? _onNextButtonPressed : null,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Text color
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
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