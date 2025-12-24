import 'package:dragonball/provider/character_detail_provider.dart';
import 'package:dragonball/provider/character_provider.dart';
import 'package:dragonball/provider/planet_detail_provider.dart';
import 'package:dragonball/provider/planet_provider.dart';
import 'package:dragonball/screens/planet_detail_screen.dart';
import 'package:dragonball/screens/planet_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/character_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CharacterProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PlanetProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PlanetDetailProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CharacterDetailProvider(),
        ),


      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CharacterListScreen(),
      ),
    );
  }
}
