import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:login_page_ui/login_page.dart';
import 'package:login_page_ui/reset_pass.dart';
import 'package:login_page_ui/widgets/appbar_widget.dart';
import 'package:page_transition/page_transition.dart';

import 'model/signUpModel.dart';

class DeleteUserPage extends StatefulWidget {
  DeleteUserPage({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  State<DeleteUserPage> createState() => _DeleteUserPageState();
}

class _DeleteUserPageState extends State<DeleteUserPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  User? user = FirebaseAuth.instance.currentUser;
  SignUpModel loggedInUser = SignUpModel();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = SignUpModel.fromMap(value.data());
      _emailController.text = "${loggedInUser.email}".trim();
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String headingAppbar = "Delete Account";
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xff101010),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                appBar(context, headingAppbar),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(height: 110),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, bottom: 7),
                              child: Text(
                                "Email",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ("Please Enter Your Email");
                                }
                                //reg expression
                                if (!RegExp(
                                        "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                    .hasMatch(value)) {
                                  return ("Please Enter a valid email");
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _emailController.text = value!;
                              },
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              focusNode: _focusNodes[0],
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.email_outlined,
                                  color: _focusNodes[0].hasFocus
                                      ? Colors.deepPurple
                                      : Colors.grey,
                                ),

                                fillColor: Color.fromARGB(100, 32, 32, 32),
                                filled: true,

                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(100, 42, 42, 42),
                                      width: 2),
                                  borderRadius: BorderRadius.circular(14),
                                ),

                                focusedBorder: GradientOutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    gradient: LinearGradient(colors: [
                                      Colors.pink,
                                      Colors.deepPurple
                                    ]),
                                    width: 1.4),
                                hintText: "Enter your Email",
                                hintStyle: TextStyle(color: Colors.grey),
                                // labelText: "Email",
                                // labelStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //passworf field
                      SizedBox(
                        height: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, bottom: 7),
                              child: Text(
                                "Password",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            TextFormField(
                              validator: (value) {
                                RegExp regex = new RegExp(r'^.{6,}$');
                                if (value!.isEmpty) {
                                  return ("Password is required for login");
                                }
                                if (!regex.hasMatch(value)) {
                                  return ("Enter Valid Password(Min. 6 Character)");
                                }
                              },
                              onSaved: (value) {
                                _passwordController.text = value!;
                              },
                              controller: _passwordController,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                fillColor: Color.fromARGB(100, 32, 32, 32),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(100, 42, 42, 42),
                                      width: 2),
                                  borderRadius: BorderRadius.circular(14),
                                ),

                                focusedBorder: GradientOutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    gradient: LinearGradient(colors: [
                                      Colors.pink,
                                      Colors.deepPurple
                                    ]),
                                    width: 1.4),
                                hintText: "Enter your Password",
                                hintStyle: TextStyle(color: Colors.grey),
                                // labelText: "Password",
                                // labelStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //delete button
                      SizedBox(height: 18),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          height: 50,
                          width: deviceWidth,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.pink, Colors.deepPurple]),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              DeleteAccount(_emailController.text,
                                  _passwordController.text);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(14),
                              ),
                            ),
                            child: Text(
                              'Delete',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Forgot your password ?",
                            style: TextStyle(color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.scale,
                                      alignment: Alignment.bottomCenter,
                                      duration: Duration(milliseconds: 800),
                                      child: ResetPasswordPage()));
                            },
                            child: Text(
                              "Reset Password",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void DeleteAccount(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      if (widget.email == email) {
        User? user1 = await _auth.currentUser;

        AuthCredential credential =
            EmailAuthProvider.credential(email: email, password: password);

        await user!.reauthenticateWithCredential(credential).then((value) {
          value.user!.delete().then((res) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false);
            Fluttertoast.showToast(msg: "Account Deleted Permanently");
          });
        }).catchError(
            (onError) => Fluttertoast.showToast(msg: "Wrong Password"));
      } else {
        Fluttertoast.showToast(msg: "Email don't match with user's mail!");
      }
    }
  }
}
