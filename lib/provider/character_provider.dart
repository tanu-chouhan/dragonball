import 'package:flutter/material.dart';
import '../models/character_model.dart';
import '../services/character_services.dart';


class CharacterProvider extends ChangeNotifier {
  final CharacterApiService _apiService = CharacterApiService();

  List<Character> characters = [];

  int _currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;

  Future<void> fetchNextCharacters() async {
    if (isLoading || !hasMore) return;

    isLoading = true;
    notifyListeners();

    try {
      final result =
      await _apiService.fetchCharacters(page: _currentPage);

      characters.addAll(result['characters']);
      hasMore = result['hasMore'];
      _currentPage++;
    } catch (e) {
      debugPrint("Error: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  void reset() {
    characters.clear();
    _currentPage = 1;
    hasMore = true;
    notifyListeners();
  }
}
