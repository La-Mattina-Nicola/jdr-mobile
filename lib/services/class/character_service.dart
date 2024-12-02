import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jdr/class/character.dart';

class CharacterService {
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> createCharacter(Character character, String userId) async {
    await userCollection.doc(userId).collection('characters').doc(character.id).set(character.toMap());
  }

  Future<Character?> readCharacter(String userId, String characterId) async {
    DocumentSnapshot doc = await userCollection.doc(userId).collection('characters').doc(characterId).get();
    if (doc.exists) {
      return Character.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> updateCharacter(Character character, String userId) async {
    await userCollection.doc(userId).collection('characters').doc(character.id).update(character.toMap());
  }

  Future<void> deleteCharacter(String userId, String characterId) async {
    await userCollection.doc(userId).collection('characters').doc(characterId).delete();
  }
}
