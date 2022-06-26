import 'package:flutter/material.dart';
import 'package:flutter_pemula/model/Destination.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsDestination extends StatelessWidget {
  final Destination place;

  const DetailsDestination({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  SizedBox(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Hero(
                      tag: "image",
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: place.imageUrls.map((url) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(url),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          const FavoriteButton(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                child: Text(
                  place.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 16.0,
                ),
                child: const Text(
                  "Address:",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                ),
                child: Text(
                  place.address,
                  style: const TextStyle(fontWeight: FontWeight.w300),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.blue),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        const Icon(
                          Icons.access_time,
                          color: Colors.green,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          place.opened,
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        const Icon(
                          Icons.currency_bitcoin,
                          color: Colors.amber,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          place.htm,
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        const Icon(
                          Icons.local_parking,
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          place.parking,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 16.0,
                ),
                child: const Text(
                  "Description:",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 64.0,
                ),
                child: Text(
                  place.description,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _launchUrl(Uri.parse(place.maps));
          },
          icon: const Icon(Icons.navigation),
          label: const Text("Navigate"),
          backgroundColor: Colors.indigoAccent,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  void _launchUrl(Uri url) async {
    if (!await launchUrl(url)) throw 'Could not launch $url';
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
    );
  }
}
