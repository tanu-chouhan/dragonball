import 'dart:convert';
import 'package:dragonball/models/planets_model.dart';
import 'package:http/http.dart' as http;


class PlanetApiService {
  static const String baseUrl =
      "https://dragonball-api.com/api/planets";

  Future<Map<String, dynamic>> fetchPlanets({
    required int page,
    int limit = 10,
  }) async {
    final url = "$baseUrl?page=$page&limit=$limit";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return {
        "planets": (data['items'] as List)
            .map((e) => Planet.fromJson(e))
            .toList(),
        "hasMore":
        data['meta']['currentPage'] < data['meta']['totalPages'],
      };
    } else {
      throw Exception("Failed to load planets");
    }
  }
}
