import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/planet_detail_provider.dart';
import 'character_detail_screen.dart';

class PlanetDetailScreen extends StatefulWidget {
  final int planetId;

  const PlanetDetailScreen({super.key, required this.planetId});

  @override
  State<PlanetDetailScreen> createState() => _PlanetDetailScreenState();
}

class _PlanetDetailScreenState extends State<PlanetDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<PlanetDetailProvider>(context, listen: false)
          .fetchPlanetDetail(widget.planetId);
    });
  }

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFFFFF3E0); // same as character screen

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Consumer<PlanetDetailProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          }

          final planet = provider.planet;
          if (planet == null) {
            return const Center(child: Text("No data found"));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// 🌍 PLANET IMAGE
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    height: 260,
                    width: double.infinity,
                    color: Colors.white,
                    child: Image.network(
                      planet.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                /// PLANET NAME
                Text(
                  planet.name.toUpperCase(),
                  style: GoogleFonts.audiowide(
                    fontSize: 30,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 6),

                /// STATUS
                Text(
                  planet.isDestroyed ? "DESTROYED" : "ALIVE",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: planet.isDestroyed
                        ? Colors.redAccent
                        : Colors.green,
                  ),
                ),

                const SizedBox(height: 18),

                /// DESCRIPTION
                Text(
                  planet.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 28),

                Divider(color: Colors.black.withOpacity(0.12)),

                const SizedBox(height: 20),

                /// CHARACTERS TITLE
                Text(
                  "CHARACTERS FROM ${planet.name.toUpperCase()}",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 18),

                /// 👤 CHARACTER GRID
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: planet.characters.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (context, index) {
                    final character = planet.characters[index];

                    return GestureDetector(
                      onTap: () {
                        /// ✅ NAVIGATION TO CHARACTER DETAIL
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CharacterDetailScreen(
                              characterId: character.id,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: bgColor, // 👈 SAME AS SCREEN BACKGROUND
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.15),
                          ),
                        ),
                        child: Column(
                          children: [
                            /// CHARACTER IMAGE (FIXED SIZE)
                            Expanded(
                              child: Image.network(
                                character.image,
                                fit: BoxFit.contain,
                              ),
                            ),

                            const SizedBox(height: 8),

                            /// CHARACTER NAME
                            Text(
                              character.name,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
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
