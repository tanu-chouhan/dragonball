import 'package:dragonball/models/character_detail_model.dart';
import 'package:dragonball/services/character_detail_service.dart';
import 'package:flutter/material.dart';

class CharacterDetailProvider extends ChangeNotifier {
  bool isLoading = false;
  CharacterDetail? character;

  Future<void> fetchCharacterDetail(int id) async {
    isLoading = true;
    notifyListeners();

    try {
      character = await CharacterDetailService().fetchCharacterDetail(id);
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }
}
