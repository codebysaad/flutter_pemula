import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pemula/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MySplashScreen(),
    );
  }
}

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<MySplashScreen> {
  late SharedPreferences dataLogin;
  late bool newUser;

  void checkLoginState() async {
    dataLogin = await SharedPreferences.getInstance();
    newUser = (dataLogin.getBool('login') ?? true);
    if (newUser == false) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    }
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () => checkLoginState());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.blue),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50.0,
                      child: Image.asset("images/app-logo.png")
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10.0)),
                    const Text(
                      "Kudus Hits",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32.0,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
