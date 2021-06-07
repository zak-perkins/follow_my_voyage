import 'package:flutter/material.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

import 'package:followmy_voyage/widgets/responsive.dart';
import 'package:followmy_voyage/widgets/top_bar_contents.dart';
import 'package:followmy_voyage/widgets/zoom_buttons.dart';

class MapPage extends StatefulWidget {
  static const String route = '/';

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: ResponsiveWidget.isSmallScreen(context)
            ? AppBar(
            backgroundColor:
            Theme.of(context).bottomAppBarColor.withOpacity(_opacity),
            elevation: 0,
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.brightness_6),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  EasyDynamicTheme.of(context).changeTheme();
                },
              ),
            ],
            title: Text(
              'FollowMy.Voyage',
              style: TextStyle(
                color: Colors.blueGrey[100],
                fontSize: 20,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
                letterSpacing: 3,
              ),
            ),
          )
              : PreferredSize(
            preferredSize: Size(screenSize.width, 1000),
            child: TopBarContents(_opacity),
          ),
        body: Center(
          child: Column(
            children: [
              Flexible(
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(51.5, -0.09),
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
                      tileProvider: NonCachingNetworkTileProvider(),
                    ),
                  ],
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
        ),
      );
    }
  }
