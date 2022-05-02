import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page_ui/delete_user.dart';
import 'package:login_page_ui/login_page.dart';
import 'package:login_page_ui/model/signUpModel.dart';
import 'package:login_page_ui/reset_pass.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;

  SignUpModel loggedInUser = SignUpModel();

  @override
  void initState() {
    loggedInUser.email = "";
    loggedInUser.name = "";
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = SignUpModel.fromMap(value.data());
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Welcome"),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    child: Text("login successful"),
                  ),
                  Text("${loggedInUser.name}"),
                  Text("${loggedInUser.email}"),
                  ElevatedButton(
                    onPressed: () {
                      logout(context);
                    },
                    child: Text("Logout"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.scale,
                              alignment: Alignment.bottomCenter,
                              duration: Duration(milliseconds: 800),
                              child: DeleteUserPage(
                                email: "${loggedInUser.email}",
                                loggedUserUid: "${loggedInUser.uid}",
                              )));
                    },
                    child: Text("Delete"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.scale,
                              alignment: Alignment.bottomCenter,
                              duration: Duration(milliseconds: 800),
                              child: ResetPasswordPage()));
                    },
                    child: Text("Reset Password"),
                  ),
                ],
              ),
            ),

            // Text(user!.email!),
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
