import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

//import 'package:follow_my_voyage/constants.dart';
import 'package:follow_my_voyage/util/zoom.dart';
import 'welcome_screen.dart';

final _firestore = FirebaseFirestore.instance;

class MapScreen extends StatefulWidget {
  static String id = 'map_screen';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _auth = FirebaseAuth.instance;

  User loggedInUser;
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getMarkerList();
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

  //List<Marker> markers = [];

  void getMarkerList() async {
    markers = await getMarkers();
    print(markers[0]);
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
                center: LatLng(-33.8688, 151.2093),
                zoom: 10.0,
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
                MarkerLayerOptions(markers: markers),
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
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // MarkersStream(),
              ]),
        ],
      ),

    );
  }
}

Future<List<Marker>> getMarkers() async {
  QuerySnapshot result = await _firestore.collection('markers').get();
  List<Marker> markers = [];

  for (DocumentSnapshot result in result.docs) {
    print(result['position'].latitude);
    print(result['position'].longitude);
    markers.add(
      Marker(
        point: LatLng(
          result['position'].latitude,
          result['position'].longitude,
        ),
        builder: (context) => Container(
          child: FloatingActionButton(
            onPressed: () {
              print(result['post']);
            },
            backgroundColor: Colors.lightBlueAccent,
            child:  ImageIcon(
              AssetImage("images/pin.png"),
              size: 22,
            ),
            /*const Icon(
              Icons.circle,
              color: Colors.red,
              size: 12.0,
            ),*/
          ),
        ),
      ),
    );
  }
  return markers;
}
/*

class MarkersStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firestore.collection('markers').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data();
              print(data);
              return Pins(data['post'], data['position']);
            }).toList(),
          );
        });
  }
}

class Pins extends StatelessWidget {
  Pins(this.post, this.position);

  final String post;
  final GeoPoint position;

  @override
  Widget build(BuildContext context) {
    print(position.latitude);
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        height: 30.0,
        width: 50.0,
        child:
            Text('$post Lat ${position.latitude} Long ${position.longitude}'),
      ), Material(
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 30.0),
                  child: Text(
                    '$position',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
    );
  }
}
*/