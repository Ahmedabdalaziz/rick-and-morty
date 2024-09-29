class Character {
  int? id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  Origin? origin; // Add the origin property
  String? image;
  List<String>? episode;
  String? url;
  String? created;

  Character({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin, // Add origin to the constructor
    this.image,
    this.episode,
    this.url,
    this.created,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json["id"],
      name: json["name"],
      status: json["status"],
      species: json["species"],
      type: json["type"],
      gender: json["gender"],
      origin: Origin.fromJson(json["origin"]),
      // Parse origin
      image: json["image"],
      episode: List<String>.from(json["episode"].map((x) => x)),
      url: json["url"],
      created: json["created"],
    );
  }
}

class Origin {
  String? name;
  String? url;

  Origin({this.name, this.url});

  factory Origin.fromJson(Map<String, dynamic> json) {
    return Origin(
      name: json["name"],
      url: json["url"],
    );
  }
}
