import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_page_ui/home_page.dart';
import 'package:login_page_ui/model/signUpModel.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin(BuildContext context) async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      postDetailsToFirestoreFromGoogleLogin(context);
    });

    notifyListeners();
  }

  postDetailsToFirestoreFromGoogleLogin(BuildContext context) async {
    //calling firestore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    FirebaseAuth _auth = FirebaseAuth.instance;

    //calling user model(from firebase predefined) and calling sign up model
    User? user = _auth.currentUser;
    SignUpModel signUpModel = SignUpModel();
    //writing all  values

    signUpModel.email = user!.email;
    signUpModel.name = user.displayName;
    signUpModel.uid = user.uid;

    //sending these values
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(signUpModel.toMap())
        .then((value) => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false));
  }
}
