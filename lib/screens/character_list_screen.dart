import 'package:dragonball/provider/character_provider.dart';
import 'package:dragonball/screens/planet_screen.dart';
import 'package:dragonball/screens/widgets/character_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    final provider =
    Provider.of<CharacterProvider>(context, listen: false);
    provider.fetchNextCharacters();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        provider.fetchNextCharacters();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),

      /// 🔹 BODY SWITCHING
      body: SafeArea(
        child: _currentIndex == 0
            ? _buildCharacterScreen()
            : const PlanetListScreen(),
      ),

      /// 🔹 BOTTOM NAVIGATION
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFF3E0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() => _currentIndex = index);
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.orange.withOpacity(0.4),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Characters",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.public),
              label: "Planets",
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 CHARACTER LIST UI (same as before)
  Widget _buildCharacterScreen() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Text(
            "DragonBall",
            textAlign: TextAlign.center,
            style: GoogleFonts.audiowide(
              fontSize: 34,
              color: Colors.black87,
              letterSpacing: 2,
            ),
          ),
        ),

        Expanded(
          child: Consumer<CharacterProvider>(
            builder: (context, provider, _) {
              return ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  bottom: 24,
                ),
                itemCount:
                provider.characters.length + (provider.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < provider.characters.length) {
                    return DragonCharacterCard(
                      character: provider.characters[index],
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
