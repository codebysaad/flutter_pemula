import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pemula/model/Destination.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'details.dart';
import 'login.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHome createState() => _MyHome();
}

class _MyHome extends State<MyHome> {
  late SharedPreferences dataLogin;
  late String email;

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    dataLogin = await SharedPreferences.getInstance();
    setState(() {
      email = dataLogin.getString('email')!;
    });
  }

  Future<bool> showExitPopup(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Keluar"),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Anda yakin ingin keluar aplikasi?"),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            exit(0);
                          },
                          style: ElevatedButton.styleFrom(primary: Colors.blue),
                          child: const Text("Ya"),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        child: const Text("Tidak",
                            style: TextStyle(color: Colors.black)),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Kudus Hits"),
          actions: [
            PopupMenuButton(
                // add icon, by default "3 dot" icon
                // icon: Icon(Icons.book)
                itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text("Logout"),
                ),
              ];
            }, onSelected: (value) {
              if (value == 0) {
                dataLogin.setBool('login', true);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              }
            }),
          ],
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            final Destination place = destinationList[index];
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DetailsDestination(place: place);
                }));
              },
              child: Card(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child:
                            Hero(tag: "image", child: Image.asset(place.icon))),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                place.name,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(place.address),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            );
          },
          itemCount: destinationList.length,
        ),
      ),
    );
  }
}
