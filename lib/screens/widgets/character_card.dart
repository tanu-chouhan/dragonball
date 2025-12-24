import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dragonball/models/character_model.dart';
import 'package:dragonball/provider/character_detail_provider.dart';
import 'package:dragonball/screens/character_detail_screen.dart';

class DragonCharacterCard extends StatefulWidget {
  final Character character;

  const DragonCharacterCard({super.key, required this.character});

  @override
  State<DragonCharacterCard> createState() => _DragonCharacterCardState();
}

class _DragonCharacterCardState extends State<DragonCharacterCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// IMAGE → DETAIL SCREEN
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChangeNotifierProvider(
                    create: (_) => CharacterDetailProvider(),
                    child: CharacterDetailScreen(
                      characterId: widget.character.id,
                    ),
                  ),
                ),
              );
            },
            child: Image.network(
              widget.character.image,
              height: 260,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 16),

          /// NAME
          Text(
            widget.character.name.toUpperCase(),
            style: GoogleFonts.audiowide(
              fontSize: 28,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 8),

          /// SUBTITLE
          Text(
            "${widget.character.race} • ${widget.character.affiliation}",
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 14),

          /// POWER LINE
          Text(
            "⚡ KI: ${widget.character.ki}  |  🔥 Max KI: ${widget.character.maxKi}",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 16),

          /// FULL DESCRIPTION (NO READ MORE)
          Text(
            widget.character.description,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 28),

          /// DIVIDER
          Divider(
            color: Colors.black.withOpacity(0.12),
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
