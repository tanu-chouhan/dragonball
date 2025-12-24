import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/character_detail_provider.dart';
import 'planet_detail_screen.dart';

class CharacterDetailScreen extends StatefulWidget {
  final int characterId;

  const CharacterDetailScreen({super.key, required this.characterId});

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<CharacterDetailProvider>(context, listen: false)
          .fetchCharacterDetail(widget.characterId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Consumer<CharacterDetailProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          }

          final character = provider.character;
          if (character == null) {
            return const Center(child: Text("No data found"));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  character.image,
                  height: 300,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 20),

                Text(
                  character.name.toUpperCase(),
                  style: GoogleFonts.audiowide(
                    fontSize: 30,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "${character.race} • ${character.gender}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 14),

                Text(
                  "⚡ KI: ${character.ki}  |  🔥 Max KI: ${character.maxKi}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  character.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 28),

                Divider(
                  color: Colors.black.withOpacity(0.12),
                ),

                const SizedBox(height: 20),

                Text(
                  "ORIGIN PLANET",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),

                const SizedBox(height: 12),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PlanetDetailScreen(
                          planetId: character.originPlanet.id,
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.network(
                      character.originPlanet.image,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PlanetDetailScreen(
                          planetId: character.originPlanet.id,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "${character.originPlanet.name.toUpperCase()} | "
                        "${character.originPlanet.isDestroyed ? "DESTROYED" : "ALIVE"}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: character.originPlanet.isDestroyed
                          ? Colors.redAccent
                          : Colors.green,
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                Divider(
                  color: Colors.black.withOpacity(0.12),
                ),

                const SizedBox(height: 20),

                Text(
                  "TRANSFORMATIONS",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  height: 160,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: character.transformations.length,
                    separatorBuilder: (_, __) =>
                    const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      final t = character.transformations[index];
                      return Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              t.image,
                              height: 110,
                              width: 110,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            t.name,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            t.ki,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}
