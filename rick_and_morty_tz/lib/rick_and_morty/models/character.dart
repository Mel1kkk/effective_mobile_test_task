import 'dart:convert';

List<Character> characterListModelFromJson(String str) {
  final jsonData = json.decode(str);
  final results = jsonData['results'] as List<dynamic>;
  return results.map((json) => Character.fromJson(json)).toList();
}

String characterListModelToJson(List<Character> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Character {
  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
    this.page,
  });

  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final CharacterLocation origin;
  final CharacterLocation location;
  final String image;
  final List<String> episode;
  final String url;
  final DateTime created;
  final int? page;

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        species: json["species"],
        type: json["type"],
        gender: json["gender"],
        origin: CharacterLocation.fromJson(json["origin"]),
        location: CharacterLocation.fromJson(json["location"]),
        image: json["image"],
        episode: List<String>.from(json["episode"].map((x) => x)),
        url: json["url"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "species": species,
        "type": type,
        "gender": gender,
        "origin": origin.toJson(),
        "location": location.toJson(),
        "image": image,
        "episode": List<dynamic>.from(episode.map((x) => x)),
        "url": url,
        "created": created.toIso8601String(),
      };
  
  factory Character.fromMap(Map<String, dynamic> map) {
    return Character(
      id: map['id'],
      name: map['name'],
      status: map['status'],
      species: map['species'],
      type: '', 
      gender: '',
      origin: CharacterLocation(name: '', url: ''),
      location: CharacterLocation(name: '', url: ''),
      image: map['image'],
      episode: [],
      url: '',
      created: DateTime.now(),
      page: map['page'],
    );
  }

  // get page => null;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'image': image,
      // 'isFavorite': 0,
      'page': page,
    };
  }  

}

class CharacterLocation {
  CharacterLocation({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory CharacterLocation.fromJson(Map<String, dynamic> json) =>
      CharacterLocation(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

