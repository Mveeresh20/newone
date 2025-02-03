import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  
  Future<User?> signUp(String email, String password) async {
    try {
      
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'email': user.email,
          'uid': user.uid,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The email is already registered.');
      } else if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'invalid-email') {
        print('The email address is invalid.');
      } else {
        print('Error during signup: $e');
      }
      return null;
    }
  }

 
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print('Error during login: $e');
      }
      return null;
    }
  }

  
  Future<void> signOut() async {
    await _auth.signOut();
  }
}

