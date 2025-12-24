import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/planet_detail_model.dart';

class PlanetDetailService {
  Future<PlanetDetail> fetchPlanetDetail(int id) async {
    final response = await http.get(
      Uri.parse("https://dragonball-api.com/api/planets/$id"),
    );

    if (response.statusCode == 200) {
      return PlanetDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load planet detail");
    }
  }
}
