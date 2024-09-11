import 'package:flutter/material.dart';
import 'gradientText.dart'; // Reusing the GradientText widget

class ArtistSelection extends StatefulWidget {
  final List<String> selectedGenres;

  const ArtistSelection({super.key, required this.selectedGenres});

  @override
  State<ArtistSelection> createState() => _ArtistSelectionState();
}

class _ArtistSelectionState extends State<ArtistSelection> {
  Map<String, List<String>> genreArtists = {
    'Rock': [
      'Artist 1', 'Artist 2', 'Artist 3', 'Artist 4', 'Artist 5',
      'Artist 6', 'Artist 7', 'Artist 8', 'Artist 9', 'Artist 10',
    ],
    'Pop': [
      'Artist 1', 'Artist 2', 'Artist 3', 'Artist 4', 'Artist 5',
      'Artist 6', 'Artist 7', 'Artist 8', 'Artist 9', 'Artist 10',
    ],
    'Hip-Hop': [
      'Artist 1', 'Artist 2', 'Artist 3', 'Artist 4', 'Artist 5',
      'Artist 6', 'Artist 7', 'Artist 8', 'Artist 9', 'Artist 10',
    ],
    'Jazz': [
      'Artist 1', 'Artist 2', 'Artist 3', 'Artist 4', 'Artist 5',
      'Artist 6', 'Artist 7', 'Artist 8', 'Artist 9', 'Artist 10',
    ],
    'Classical': [
      'Artist 1', 'Artist 2', 'Artist 3', 'Artist 4', 'Artist 5',
      'Artist 6', 'Artist 7', 'Artist 8', 'Artist 9', 'Artist 10',
    ],
    'Electronic': [
      'Artist 1', 'Artist 2', 'Artist 3', 'Artist 4', 'Artist 5',
      'Artist 6', 'Artist 7', 'Artist 8', 'Artist 9', 'Artist 10',
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
