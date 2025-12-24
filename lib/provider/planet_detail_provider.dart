import 'package:flutter/material.dart';
import '../models/planet_detail_model.dart';
import '../services/planet_detail_service.dart';

class PlanetDetailProvider extends ChangeNotifier {
  bool isLoading = false;
  PlanetDetail? planet;

  Future<void> fetchPlanetDetail(int id) async {
    isLoading = true;
    notifyListeners();

    try {
      planet = await PlanetDetailService().fetchPlanetDetail(id);
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }
}
