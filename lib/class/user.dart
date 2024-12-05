import 'package:jdr/class/character.dart';
import 'package:jdr/services/class/user_service.dart';

class User {
  String? id;
  String name;
  String email;
  List<Character>? characters;

  User({
    this.id,
    required this.name,
    required this.email,
    this.characters,
  });

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, characters: $characters}';
  }

  Future<void> createUser() async {
    await UserService().createUser(this);
  }

  static Future<User?> readUser(String id) async {
    return await UserService().readUser(id);
  }

  Future<void> updateUser() async {
    await UserService().updateUser(this);
  }

  static Future<void> deleteUser(String id) async {
    await UserService().deleteUser(id);
  }

  Future<void> createCharacterCollection() async {
    await UserService().createCharacterCollection(id!);
  }

  Character? findCharacterById(String id) {
    try {
      return characters!.firstWhere((character) => character.id == id);
    } catch (e) {
      return null;
    }
  }

  void updateName(String newName) {
    name = newName;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'characters': characters?.map((character) => character.toMap()).toList(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['uid'],
      name: map['name'],
      email: map['email'],
      characters: List<Character>.from(map['characters']?.map((item) => Character.fromMap(item)) ?? []),
    );
  }
}
