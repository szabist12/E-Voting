import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:app/OnBoarding_Screen/OnBoarding_Screen.dart';
import 'package:app/login_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>OnBoardingScreen(showHome: false),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      //  splash: Lottie.asset('assets/loading-circles.json'),
      splash:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300,
            height: 200,

            child: Image.asset('assets/images/positive-vote.png'),
          ),

          const Text(
            'WE VOTE',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Text(
            'Secure-Certified-evoting',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.blueAccent,
      nextScreen: Container(), // A temporary placeholder widget
      splashIconSize: 600,

      splashTransition: SplashTransition.rotationTransition,
      animationDuration: const Duration(seconds: 3),
    );
  }
}
