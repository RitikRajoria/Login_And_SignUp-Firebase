import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:login_page_ui/login_page.dart';
import 'package:login_page_ui/model/signUpModel.dart';
import 'package:login_page_ui/widgets/appbar_widget.dart';
import 'package:login_page_ui/widgets/logoBtn.dart';
import 'package:page_transition/page_transition.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String headingAppbar = "Sign up";

  final _auth = FirebaseAuth.instance;
  

  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  List<FocusNode> _focusNodesEmail = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void initState() {
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
    // super.initState();

    _focusNodesEmail.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
    super.initState();
  }

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  bool showPassword = true;
  void togglePasswordVisibility() =>
      setState(() => showPassword = !showPassword);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xff101010),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appBar(context, headingAppbar),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Sign up with one of the following options.",
                      style: TextStyle(color: Color(0xffb8b8b8)),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: logoBtn(context),
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, bottom: 4),
                          child: Text(
                            "Name",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{3,}$');
                            if (value!.isEmpty) {
                              return ("Name cannot be Empty!");
                            }
                            if (!regex.hasMatch(value)) {
                              return ("Enter Minimum 3 Character For Your Name. ");
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _nameController.text = value!;
                          },
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          focusNode: _focusNodes[0],
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.done,
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
                            hintText: "Enter your Name",
                            hintStyle: TextStyle(color: Colors.grey),
                            // labelText: "Email",
                            // labelStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          focusNode: _focusNodesEmail[0],
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.email_outlined,
                              color: _focusNodesEmail[0].hasFocus
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
                    height: 10,
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

                  SizedBox(height: 10),

                  //Signup button
                  SizedBox(height: 10),
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
                          signUp(
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
                          'Sign up',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),

                  //Already have an account button text

                  SizedBox(height: 3),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an Account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/login');
                        },
                        child: Text(
                          "Log in",
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

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    //calling firestore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    //calling user model(from firebase predefined) and calling sign up model
    User? user = _auth.currentUser;
    SignUpModel signUpModel = SignUpModel();
    //writing all  values

    signUpModel.email = user!.email;
    signUpModel.name = _nameController.text;
    signUpModel.uid = user.uid;

    //sending these values
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(signUpModel.toMap());
    Fluttertoast.showToast(msg: "Account Created Successfully :)");

    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.scale,
            alignment: Alignment.bottomCenter,
            duration: Duration(milliseconds: 800),
            child: LoginPage()));
  }
}
