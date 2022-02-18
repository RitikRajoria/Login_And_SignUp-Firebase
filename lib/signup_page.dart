import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:login_page_ui/widgets/appbar_widget.dart';
import 'package:login_page_ui/widgets/logoBtn.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String headingAppbar = "Sign up";

  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  List<FocusNode> _focusNodesEmail = [
    FocusNode(),
    FocusNode(),
  ];

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

  bool showPassword = true;
  void togglePasswordVisibility() =>
      setState(() => showPassword = !showPassword);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromRGBO(16, 16, 16, 100),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                      TextField(
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
                      TextField(
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
                      TextField(
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
                      onPressed: () {},
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
    );
  }
}
