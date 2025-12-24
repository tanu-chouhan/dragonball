import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character_detail_model.dart';

class CharacterDetailService {
  Future<CharacterDetail> fetchCharacterDetail(int id) async {
    final response = await http.get(
      Uri.parse("https://dragonball-api.com/api/characters/$id"),
    );

    if (response.statusCode == 200) {
      return CharacterDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load character detail");
    }
  }
}
