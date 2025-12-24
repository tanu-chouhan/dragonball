class CharacterDetail {
  final int id;
  final String name;
  final String ki;
  final String maxKi;
  final String race;
  final String gender;
  final String description;
  final String image;
  final String affiliation;
  final OriginPlanet originPlanet;
  final List<Transformation> transformations;

  CharacterDetail({
    required this.id,
    required this.name,
    required this.ki,
    required this.maxKi,
    required this.race,
    required this.gender,
    required this.description,
    required this.image,
    required this.affiliation,
    required this.originPlanet,
    required this.transformations,
  });

  factory CharacterDetail.fromJson(Map<String, dynamic> json) {
    return CharacterDetail(
      id: json['id'],
      name: json['name'],
      ki: json['ki'],
      maxKi: json['maxKi'],
      race: json['race'],
      gender: json['gender'],
      description: json['description'],
      image: json['image'],
      affiliation: json['affiliation'],
      originPlanet: OriginPlanet.fromJson(json['originPlanet']),
      transformations: (json['transformations'] as List)
          .map((e) => Transformation.fromJson(e))
          .toList(),
    );
  }
}

class OriginPlanet {
  final int id;
  final String name;
  final bool isDestroyed;
  final String description;
  final String image;

  OriginPlanet({
    required this.id,
    required this.name,
    required this.isDestroyed,
    required this.description,
    required this.image,
  });

  factory OriginPlanet.fromJson(Map<String, dynamic> json) {
    return OriginPlanet(
      id: json['id'],
      name: json['name'],
      isDestroyed: json['isDestroyed'],
      description: json['description'],
      image: json['image'],
    );
  }
}

class Transformation {
  final int id;
  final String name;
  final String image;
  final String ki;

  Transformation({
    required this.id,
    required this.name,
    required this.image,
    required this.ki,
  });

  factory Transformation.fromJson(Map<String, dynamic> json) {
    return Transformation(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      ki: json['ki'],
    );
  }
}
