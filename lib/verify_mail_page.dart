import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_page_ui/login_page.dart';
import 'package:login_page_ui/widgets/appbar_widget.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';

class VerifyMailPage extends StatefulWidget {
  const VerifyMailPage({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  State<VerifyMailPage> createState() => _VerifyMailPageState();
}

class _VerifyMailPageState extends State<VerifyMailPage> {
  bool isemailVerified = false;
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isemailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isemailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isemailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isemailVerified) {
      timer?.cancel();
    }
  }

  @override
  void dispose() {
    timer!.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  bool resendOn = false;

  bool resendButton() {
    resendOn = true;
    return resendOn;
  }

  final CountDownController _timercontroller = new CountDownController();

  @override
  Widget build(BuildContext context) => isemailVerified
      ? LoginPage()
      : Scaffold(
          backgroundColor: Color(0xff101010),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  appBar(null, "Verify Mail"),
                  SizedBox(
                    height: 150,
                  ),
                  Text(
                    "A Verification Email has been sent to",
                    style: TextStyle(
                        color: Colors.white, fontSize: 18, height: 1.4),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    widget.email,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        height: 1.4,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  //clock
                  SizedBox(
                    height: 50,
                  ),

                  NeonCircularTimer(
                    width: 200,
                    duration: 60,
                    backgroudColor: Colors.transparent,
                    outerStrokeColor: Colors.transparent,
                    neonColor: Colors.white,
                    controller: _timercontroller,
                    isTimerTextShown: true,
                    textStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 35,
                        fontWeight: FontWeight.w500),
                    neumorphicEffect: true,
                    innerFillGradient: LinearGradient(colors: [
                      Colors.pink,
                      Colors.deepPurpleAccent,
                    ]),
                    neonGradient: LinearGradient(
                        colors: [Colors.pink, Colors.deepPurpleAccent]),
                    onComplete: () {
                      resendButton();
                      setState(() {});
                    },
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  //text for resending mail
                  if (resendOn)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't recieved an email?",
                          style: TextStyle(
                              color: Colors.white, fontSize: 15, height: 1.4),
                        ),
                        GestureDetector(
                          onTap: () {
                            print("resending");
                            sendVerificationEmail();
                            _timercontroller.restart();
                          },
                          child: Text(
                            "  Resend Email",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              height: 1.4,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
}
