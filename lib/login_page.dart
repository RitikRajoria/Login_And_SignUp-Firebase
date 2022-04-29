import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:login_page_ui/home_page.dart';
import 'package:login_page_ui/signup_page.dart';
import 'package:login_page_ui/widgets/appbar_widget.dart';
import 'package:login_page_ui/widgets/logoBtn.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;

  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  void initState() {
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
    super.initState();
  }

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool showPassword = true;
  void togglePasswordVisibility() =>
      setState(() => showPassword = !showPassword);

  @override
  Widget build(BuildContext context) {
    String headingAppbar = "Log in";
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff101010),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //appbar
                  appBar(null, headingAppbar),

                  //after appbar

                  SizedBox(height: 50),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Log in with one of the following options.",
                      style: TextStyle(color: Color(0xffb8b8b8)),
                    ),
                  ),

                  SizedBox(height: 13),

                  logoBtn(context),

                  SizedBox(height: 40),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, bottom: 4),
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
                                gradient: LinearGradient(
                                    colors: [Colors.pink, Colors.deepPurple]),
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

                  SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, bottom: 4),
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
                          obscureText: showPassword,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: showPassword
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
                              color: Colors.grey,
                              onPressed: togglePasswordVisibility,
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
                                gradient: LinearGradient(
                                    colors: [Colors.pink, Colors.deepPurple]),
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

                  //login button
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                          signIn(
                              _emailController.text, _passwordController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          'Log in',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),

                  //create account button text

                  SizedBox(height: 3),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an Account ?",
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
                                  child: SignupPage()));
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//login functionality
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (route) => false),
              })
          .catchError((e) {
        Fluttertoast.showToast(
          toastLength: Toast.LENGTH_LONG,
          msg: e!.message,
          // msg:
          //     "We can't find an account with ${_emailController.text} mail. Try another mail or if you don't have an account, you can sign up.",
        );
      });
    }
  }
}
