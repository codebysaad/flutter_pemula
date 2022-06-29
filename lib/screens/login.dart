import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pemula/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController getEmail = TextEditingController();
TextEditingController getPass = TextEditingController();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscure = true;
  late SharedPreferences dataLogin;
  late bool newUser;

  @override
  void initState() {
    super.initState();
    checkLoginState();
  }

  void checkLoginState() async {
    dataLogin = await SharedPreferences.getInstance();
    newUser = (dataLogin.getBool('login') ?? true);
    if (newUser == false) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          key: _scaffoldKey,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Text(
                  'WELCOME to\nKUDUS HITS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blue[700],
                      fontSize: 32,
                      letterSpacing: 4.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 50),
                Text(
                  'Explore destination in Kudus',
                  style: TextStyle(
                      color: Colors.blue[300],
                      fontSize: 18,
                      letterSpacing: 1.0),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: getEmail,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      contentPadding: const EdgeInsets.only(
                          left: 30.0, bottom: 20.0, top: 20.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: 'Email',
                      labelStyle: const TextStyle(color: Colors.blue),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: _isObscure,
                    controller: getPass,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      contentPadding: const EdgeInsets.only(
                          left: 30.0, top: 20.0, bottom: 20.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.blue),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.blue,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: MaterialButton(
                      height: 55,
                      textColor: Colors.white,
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          letterSpacing: 2,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () {
                        String email = 'example@dicoding.com';
                        String pass = 'dicoding';
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          if (getEmail.text.isEmpty) {
                            const errorUser = SnackBar(
                              content: Text('Email tidak boleh kosong!'),
                              duration: Duration(seconds: 2),
                            );
                            _scaffoldKey.currentState?.showSnackBar(errorUser);
                          } else if (getPass.text.isEmpty) {
                            const errorPassword = SnackBar(
                              content: Text('Password tidak boleh kosong!'),
                              duration: Duration(seconds: 2),
                            );
                            _scaffoldKey.currentState
                                ?.showSnackBar(errorPassword);
                          } else if (getEmail.text == email &&
                              getPass.text == pass) {
                            final messageWelcome = SnackBar(
                              content: Text(
                                  'Selamat datang email: ${getEmail.text}'),
                              duration: const Duration(seconds: 2),
                            );
                            _scaffoldKey.currentState
                                ?.showSnackBar(messageWelcome);
                            //delay to Home page
                            Timer(const Duration(seconds: 2), () {
                              dataLogin.setBool('login', false);
                              dataLogin.setString('email', email);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
                            });
                          } else {
                            const errorUser = SnackBar(
                              content: Text('Cek kembali input anda!'),
                              duration: Duration(seconds: 2),
                            );
                            _scaffoldKey.currentState?.showSnackBar(errorUser);
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
