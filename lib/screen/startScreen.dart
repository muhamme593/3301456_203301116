import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sampleproject/screen/authScreen.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/udemy.png',
              height: 180,
              width: 180,
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Welcome to the',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Udemy',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.red[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  'app',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account ?!',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  width: 5,
                ),
                TextButton(
                  onPressed: (() {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        child: authScreen(authMode: AuthMode.Login),
                        type: PageTransitionType.bottomToTop,
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  }),
                  child: Text(
                    'Log in',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[600],
                      decoration: TextDecoration.underline,
                      decorationThickness: 2,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              onPressed: (() {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    child: authScreen(authMode: AuthMode.SignUp),
                    type: PageTransitionType.bottomToTop,
                    duration: Duration(milliseconds: 300),
                  ),
                );
              }),
              child: Container(
                alignment: Alignment.center,
                height: 50,
                // padding: EdgeInsets.all(20),
                child: Text(
                  'Create account now',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
