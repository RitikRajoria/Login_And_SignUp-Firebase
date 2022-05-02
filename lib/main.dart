import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:login_page_ui/login_page.dart';
import 'package:login_page_ui/provider/google_sign_in.dart';
import 'package:login_page_ui/signup_page.dart';
import 'package:login_page_ui/widgets/appbar_widget.dart';
import 'package:login_page_ui/widgets/logoBtn.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
    ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        home: LoginPage(),
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/login': (BuildContext context) => new LoginPage(),
          '/signup': (BuildContext context) => new SignupPage()
        },
      ),
    );
  
}
