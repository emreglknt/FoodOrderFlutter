import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseAuthService {


  FirebaseAuth _auth = FirebaseAuth.instance;

  //register
  Future<User?> signupWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }on FirebaseAuthException catch(e){
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: "The email address is already in use.");
      } else {
        Fluttertoast.showToast(msg: "An error occured.${e.code}");
      }
    }
    return null;

  }


//login
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential =await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Invalid email or password.');
      } else {
        Fluttertoast.showToast(msg: 'An error occurred: ${e.code}');
      }

    }
    return null;

  }





}