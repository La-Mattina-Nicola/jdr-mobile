import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jdr/class/stat.dart';

class StatService {
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> createStat(Stat stat, String userId, String characterId) async {
    await userCollection.doc(userId).collection('characters').doc(characterId).collection('stats').doc(stat.id).set(stat.toMap());
  }

  Future<Stat?> readStat(String userId, String characterId, String statId) async {
    DocumentSnapshot doc = await userCollection.doc(userId).collection('characters').doc(characterId).collection('stats').doc(statId).get();
    if (doc.exists) {
      return Stat.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> updateStat(Stat stat, String userId, String characterId) async {
    await userCollection.doc(userId).collection('characters').doc(characterId).collection('stats').doc(stat.id).update(stat.toMap());
  }

  Future<void> deleteStat(String userId, String characterId, String statId) async {
    await userCollection.doc(userId).collection('characters').doc(characterId).collection('stats').doc(statId).delete();
  }
}
