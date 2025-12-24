import 'package:dragonball/models/planets_model.dart';
import 'package:dragonball/services/planet_service.dart';
import 'package:flutter/material.dart';


class PlanetProvider extends ChangeNotifier {
  final PlanetApiService _apiService = PlanetApiService();

  List<Planet> planets = [];

  int _currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;

  Future<void> fetchNextPlanets() async {
    if (isLoading || !hasMore) return;

    isLoading = true;
    notifyListeners();

    try {
      final result =
      await _apiService.fetchPlanets(page: _currentPage);

      planets.addAll(result['planets']);
      hasMore = result['hasMore'];
      _currentPage++;
    } catch (e) {
      debugPrint("Planet error: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  void reset() {
    planets.clear();
    _currentPage = 1;
    hasMore = true;
    notifyListeners();
  }
}
