class PlanetDetail {
  final int id;
  final String name;
  final bool isDestroyed;
  final String description;
  final String image;
  final List<PlanetCharacter> characters;

  PlanetDetail({
    required this.id,
    required this.name,
    required this.isDestroyed,
    required this.description,
    required this.image,
    required this.characters,
  });

  factory PlanetDetail.fromJson(Map<String, dynamic> json) {
    return PlanetDetail(
      id: json['id'],
      name: json['name'],
      isDestroyed: json['isDestroyed'],
      description: json['description'],
      image: json['image'],
      characters: (json['characters'] as List)
          .map((e) => PlanetCharacter.fromJson(e))
          .toList(),
    );
  }
}

class PlanetCharacter {
  final int id;
  final String name;
  final String image;

  PlanetCharacter({
    required this.id,
    required this.name,
    required this.image,
  });

  factory PlanetCharacter.fromJson(Map<String, dynamic> json) {
    return PlanetCharacter(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
