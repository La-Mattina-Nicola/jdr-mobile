import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jdr/class/character.dart';
import 'package:jdr/class/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:jdr/services/class/character_service.dart';

class UserService {
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final CharacterService characterService = CharacterService();

  Future<void> createUser(User user) async {
    await userCollection.doc(user.id).set(user.toMap());
  }

  Future<User?> readUser(String id) async {
    DocumentSnapshot doc = await userCollection.doc(id).get();
    if (doc.exists) {
      return User.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> updateUser(User user) async {
    await userCollection.doc(user.id).update(user.toMap());
  }

  Future<void> deleteUser(String id) async {
    await userCollection.doc(id).delete();
  }

  Future<User> getCurrentUser() async {
    final auth.User? firebaseUser = auth.FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      DocumentSnapshot userDoc = await userCollection.doc(firebaseUser.uid).get();
      if (userDoc.exists) {
        List<Character> characters = await characterService.getUserCharacters(firebaseUser.uid);
        await Future.delayed(Duration(seconds: 1));
        return User.fromMap(userDoc.data() as Map<String, dynamic>)..characters = characters;
      }
    }
    throw Exception("User not found or not logged in");
  }

  Future<void> createCharacterCollection(String id) async {
    userCollection.doc(id).collection("characters").doc().set({});
  }
}
