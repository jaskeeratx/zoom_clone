import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/utils/showSnackbar.dart';


class AuthMethods {

  Stream<User?> get authChanges => _auth.authStateChanges();

  // waking up the manager so it dont waste the time later on or starting the engine before moving the car
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User get user => _auth.currentUser!;
  // this will give the pop up yeah do you want to sign in with google? i will give you the pass but gimme the id.
  // Future<bool?> signInWithGoogle(BuildContext context) async {
  //   bool res = false;
  //   try {
  //     // Ensure Google Sign-In is initialized if not then it will initialize.
  //     await GoogleSignIn.instance.initialize();
  //       // checks if your phone even supports the google sign in or not?
  //     if (!GoogleSignIn.instance.supportsAuthenticate()) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content:
  //           Text("GoogleSignIn: This platform does not support authenticate()"),
  //         ),
  //       );
  //       return null;
  //     }
  //
  //     // 🔥 NEW SIGN-IN CALL
  //     final GoogleSignInAccount googleUser =
  //     await GoogleSignIn.instance.authenticate(
  //       scopeHint: ['email', 'openid', 'profile'],
  //     );
  //
  //     // Get authentication tokensGoogle looks at your ID
  //     //  If you are real → Google creates a secret pass
  //     final googleAuth = await googleUser.authentication;
  //
  //     if (googleAuth.idToken == null) {
  //       throw Exception("Failed to obtain ID Token");
  //     }
  //     //You give your pass to Firebase Manager
  //     //  Firebase checks with Google:
  //     // “Is this a real Google user?”
  //     //  Google says “Yes!” 😎
  //     // Firebase Credential
  //     final credential = GoogleAuthProvider.credential(
  //       idToken: googleAuth.idToken,
  //        // may be null on Android WebView
  //     );
  //
  //     // Sign in with Firebase
  //     UserCredential userCredential =
  //     await _auth.signInWithCredential(credential);
  //
  //     User? user = userCredential.user;
  //     if (user != null) {
  //       if (userCredential.additionalUserInfo!.isNewUser) {
  //         _firestore.collection('users').doc(user.uid).set({
  //           'username': user.displayName,
  //           'uid': user.uid,
  //           'profilePhoto': user.photoURL,
  //         });
  //       }
  //     }
  //
  //     return  true;
  //
  //
  //
  //   } on FirebaseAuthException  catch (e) {
  //     showSnackBar(context, e.message!);
  //     return false;
  //   }
  // }
  Future<bool?> signInWithGoogle(BuildContext context) async {
    bool res = false;
    try {
      await GoogleSignIn.instance.initialize();

      if (!GoogleSignIn.instance.supportsAuthenticate()) {
        showSnackBar(context, "Google Sign-In not supported on this device");
        return null;
      }

      final GoogleSignInAccount googleUser =
      await GoogleSignIn.instance.authenticate(
        scopeHint: ['email', 'openid', 'profile'],
      );

      final googleAuth = await googleUser.authentication;

      if (googleAuth.idToken == null) {
        throw Exception("Failed to obtain ID Token");
      }

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      User? user = userCredential.user;

      if (user != null &&
          userCredential.additionalUserInfo!.isNewUser) {
        await _firestore.collection('users').doc(user.uid).set({
          'username': user.displayName,
          'uid': user.uid,
          'profilePhoto': user.photoURL,
        });
      }

      return true; // SUCCESS
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        showSnackBar(context, "Sign-in canceled");
      } else {
        showSnackBar(context, "Google Sign-In failed: ${e.code}");
      }
      return false;
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message ?? "Auth error");
      return false;
    } catch (e) {
      showSnackBar(context, "Error: $e");
      return false;
    }
  }


  Future<void> signOut() async {
    await GoogleSignIn.instance.disconnect();
    await _auth.signOut();
  }
}
