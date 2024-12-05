import 'package:jdr/class/stat.dart';
import 'package:jdr/services/class/character_service.dart';
import 'package:uuid/uuid.dart';

class Character {
  String? id;
  String name;
  String characterClass;
  String game;
  String? other;
  String? imageUrl;
  List<Stat> stats;

  static const Uuid _uuid = Uuid();

  Character({
    String? id,
    required this.name,
    required this.characterClass,
    required this.game,
    this.other,
    this.imageUrl,
    this.stats = const [],
  }) : id = id ?? _uuid.v4();

  Future<void> createCharacter(String userId) async {
    await CharacterService().createCharacter(this, userId);
  }

  static Future<Character?> readCharacter(String userId, String characterId) async {
    return await CharacterService().readCharacter(userId, characterId);
  }

  Future<void> updateCharacter(String userId) async {
    await CharacterService().updateCharacter(this, userId);
  }

  static Future<void> deleteCharacter(String userId, String characterId) async {
    await CharacterService().deleteCharacter(userId, characterId);
  }

  Stat? findStatByName(String name) {
    try {
      return stats.firstWhere((stat) => stat.name == name);
    } catch (e) {
      return null;
    }
  }

  void updateGame(String newGame) {
    game = newGame;
  }

  @override
  String toString() {
    return 'User{name: $name, characterClass: $characterClass, stats: $stats}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'class': characterClass,
      'game': game,
      'other': other,
      'imageUrl': imageUrl ?? '',
      'stats': stats.map((stat) => stat.toMap()).toList(),
    };
  }

  factory Character.fromMap(Map<String, dynamic> map) {
    return Character(
      id: map['id'],
      name: map['name'],
      characterClass: map['class'],
      game: map['game'],
      other: map['other'],
      imageUrl: map['imageUrl'],
      stats: List<Stat>.from(map['stats']?.map((item) => Stat.fromMap(item)) ?? []),
    );
  }

}
