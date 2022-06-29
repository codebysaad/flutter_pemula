import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pemula/model/Destination.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'details.dart';
import 'login.dart';

class Home extends StatelessWidget {

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
            backgroundColor: Colors.blue,
            actions: const [
              MyPopupMenu(),
            ],
          ),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth < 600) {
              return ListView(
                children: _generateContainers(context),
              );
            } else if (constraints.maxWidth < 900) {
              return GridView.count(
                crossAxisCount: 2,
                children: _generateGridContainers(context),
              );
            } else {
              return GridView.count(
                crossAxisCount: 6,
                children: _generateGridContainers(context),
              );
            }
          })),
    );
  }

  List<Widget> _generateContainers(BuildContext context) {
    return List<Widget>.generate(destinationList.length, (index) {
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
                  child: Hero(tag: place.icon, child: Image.asset(place.icon))),
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
    });
  }

  List<Widget> _generateGridContainers(BuildContext context) {
    return List<Widget>.generate(destinationList.length, (index) {
      final Destination place = destinationList[index];
      return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DetailsDestination(place: place);
          }));
        },
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: Hero(tag: place.icon, child: Image.asset(place.icon))),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    place.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class MyPopupMenu extends StatefulWidget {
  const MyPopupMenu({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyPopup();
  }
}

class _MyPopup extends State<MyPopupMenu> {

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

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
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
    });
  }

}
