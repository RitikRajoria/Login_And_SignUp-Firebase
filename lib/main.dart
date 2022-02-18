import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:login_page_ui/signup_page.dart';
import 'package:login_page_ui/widgets/appbar_widget.dart';
import 'package:login_page_ui/widgets/logoBtn.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(

          //backgroundColor: Color.fromRGBO(16, 16, 16,100),
          ),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new LoginPage(),
        '/signup': (BuildContext context) => new SignupPage()
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();

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
  bool showPassword = true;
  void togglePasswordVisibility() => setState(() => showPassword = !showPassword);

  @override
  Widget build(BuildContext context) {
    
    String headingAppbar = "Log in";
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(16, 16, 16, 100),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
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
                      TextField(
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
                      onPressed: () {},
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
                        Navigator.of(context).pushNamed('/signup');
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
    );
  }
  
}

