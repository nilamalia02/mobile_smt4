import 'package:firebase_auth/firebase_auth.dart';
import 'package:tokoku/models/store_model.dart';
import 'package:tokoku/models/user_model.dart';
import 'package:tokoku/services/user_service.dart';

class AuthService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserModel> signUp({
    required String namaToko,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel user = UserModel(
        id: userCredential.user!.uid,
        namaToko: namaToko,
        email: email,
        password: password,
      );
      await UserService().createUser(user);
      return user;
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await UserService().getCurrentUser(userCredential.user!.uid);
      return UserService().getCurrentUser(userCredential.user!.uid);
    } catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw e;
    }
  }
}
