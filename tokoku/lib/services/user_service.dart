import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tokoku/models/user_model.dart';

class UserService {
  CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUser(UserModel user) async {
    try {
      _userCollection.doc(user.id).set({
        'id': user.id,
        'nama_toko': user.namaToko,
        'email': user.email,
        'password': user.password,
      });
    } catch (e) {
      throw e;
    }
  }

  // get current user
  Future<UserModel> getCurrentUser(String id) async {
    try {
      DocumentSnapshot snapshot = await _userCollection.doc(id).get();
      return UserModel(
        id: snapshot['id'],
        namaToko: snapshot['nama_toko'],
        email: snapshot['email'],
        password: snapshot['password'],
      );
    } catch (e) {
      throw e;
    }
  }
}
