import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  //Creating firebaseAuth instance//
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //for new user registration//
  Future<User? /*CanBeNull*/ > register(String email, password,
      BuildContext context /*EnableContextBuilding*/) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } /*ForFirebaseException*/ on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message.toString()),
        backgroundColor: Colors.red,
      ));
    } /*ForOtherException*/ catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
    return null; /*ForNullSefty*/
  }

  //Login user//
  Future<User? /*CanBeNull*/ > login(String email, password,
      BuildContext context /*EnableContextBuilding*/) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } /*ForFirebaseException*/ on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message.toString()),
        backgroundColor: Colors.red,
      ));
    } /*ForOtherException*/ catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
    return null; /*ForNullSefty*/
  }

  //for google login//
  Future<User? /*CanBeNull*/ > googleLogin(
      BuildContext context /*EnableContextBuilding*/) async {
    try {
      //Triggering the authentication dialog flow//
      //this code brings out the popup dialog//
      final GoogleSignInAccount? /*CanBeNull*/ googleUser =
          await GoogleSignIn().signIn();
      if (googleUser != null) {
        //Obtaining the auth details from the request//
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        //Creating a new credential//
        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        //Once signed in, return the UserCredential//
        UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);
        return userCredential.user;
      }
    } /*ForOtherException*/ catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
    return null; /*ForNullSefty*/
  }

  //for Logout//
  Future exit() async {
    await firebaseAuth.signOut(); /*ForEmailAndPass*/
    await GoogleSignIn().signOut(); /*ForGoogle*/

  }
}
