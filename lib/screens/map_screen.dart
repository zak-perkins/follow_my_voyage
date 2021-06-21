import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlng/latlng.dart';

//import 'package:follow_my_voyage/constants.dart';
import 'package:follow_my_voyage/widgets/zoom.dart';
import 'welcome_screen.dart';

//final _firestore = FirebaseFirestore.instance;

class MapScreen extends StatefulWidget {
  static String id = 'map_screen';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();
  User loggedInUser;
  String messageText;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pushNamed(context, WelcomeScreen.id);
              }),
        ],
        title: Text(''),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            child: FlutterMap(
              options: MapOptions(
                //center: LatLng(51.5, -0.09),
                zoom: 5.0,
                plugins: [
                  ZoomButtonsPlugin(),
                ],
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                  // For example purposes. It is recommended to use
                  // TileProvider with a caching and retry strategy, like
                  // NetworkTileProvider or CachedNetworkTileProvider
                  tileProvider: NonCachingNetworkTileProvider(),
                ),
                //MarkerLayerOptions(markers: markers)
              ], //Layers
              nonRotatedLayers: [
                ZoomButtonsPluginOption(
                  minZoom: 4,
                  maxZoom: 19,
                  mini: true,
                  padding: 10,
                  alignment: Alignment.bottomRight,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
