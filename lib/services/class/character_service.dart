import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jdr/class/character.dart';
import 'package:jdr/class/stat.dart';

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

  Future<List<Character>> getUserCharacters(String userId) async {
    QuerySnapshot characterSnapshot = await userCollection.doc(userId).collection('characters').get();
    return characterSnapshot.docs.map((doc) => Character.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }
  
  Future<void> addStatToCharacter(String userId, String characterId, Stat stat) async {
    DocumentReference characterDoc = userCollection.doc(userId).collection('characters').doc(characterId);
    await characterDoc.update({
      'stats': FieldValue.arrayUnion([stat.toMap()])
    });
  }

}
