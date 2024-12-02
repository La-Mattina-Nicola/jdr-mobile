import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jdr/class/user.dart';

class UserService {
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

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
}
