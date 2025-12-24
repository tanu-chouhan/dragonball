import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character_model.dart';

class CharacterApiService {
  static const String baseUrl =
      "https://dragonball-api.com/api/characters";

  Future<Map<String, dynamic>> fetchCharacters({
    required int page,
    int limit = 10,
  }) async {
    final url = "$baseUrl?page=$page&limit=$limit";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return {
        "characters": (data['items'] as List)
            .map((e) => Character.fromJson(e))
            .toList(),
        "hasMore": data['meta']['currentPage'] <
            data['meta']['totalPages'],
      };
    } else {
      throw Exception("Failed to load characters");
    }
  }
}
