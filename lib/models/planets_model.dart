class Planet {
  final int id;
  final String name;
  final bool isDestroyed;
  final String description;
  final String image;

  Planet({
    required this.id,
    required this.name,
    required this.isDestroyed,
    required this.description,
    required this.image,
  });

  factory Planet.fromJson(Map<String, dynamic> json) {
    return Planet(
      id: json['id'],
      name: json['name'] ?? '',
      isDestroyed: json['isDestroyed'] ?? false,
      description: json['description'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
