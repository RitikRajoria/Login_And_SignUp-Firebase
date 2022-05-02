import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:login_page_ui/login_page.dart';
import 'package:login_page_ui/widgets/appbar_widget.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String headingAppbar = "Reset Password";
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
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      SizedBox(height: 140),
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
                              focusNode: _focusNode,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.email_outlined,
                                  color: _focusNode.hasFocus
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
                            SizedBox(height: 30),
                            Container(
                              height: 50,
                              width: deviceWidth,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [Colors.pink, Colors.deepPurple]),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  PasswordResetMail(_emailController.text);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(14),
                                  ),
                                ),
                                child: Text(
                                  'Submit',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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

  void PasswordResetMail(String email) async {
    if (_formKey.currentState!.validate()) {
      await _auth.sendPasswordResetEmail(email: email).then((value) {
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "A link has been sent to your registered mail.",
            toastLength: Toast.LENGTH_LONG);
      }).catchError((error) => Fluttertoast.showToast(
          msg:
              "Email address not found. Check your email for any spelling errors.",
          toastLength: Toast.LENGTH_SHORT));
    }
  }
}
