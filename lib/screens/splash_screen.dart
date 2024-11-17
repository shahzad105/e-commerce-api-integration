import 'package:flutter/material.dart';
import 'dart:async'; // Import this for Timer
import 'package:max_cart/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black38, Colors.black45],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          image: DecorationImage(
            image: AssetImage('images/image2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Icon(
            Icons.shopping_cart,
            size: 70,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
