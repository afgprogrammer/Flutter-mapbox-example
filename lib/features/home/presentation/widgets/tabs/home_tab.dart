import 'package:flutter/material.dart';
import 'package:mapbox_example/app/constants.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late MapboxMap mapboxMap;

  String mapboxToken = AppConstants.mapboxToken;

  Future<void> _onMapCreated(MapboxMap createdMap) async {
    MapboxOptions.setAccessToken(mapboxToken);
    mapboxMap = createdMap;
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: MapWidget(
        key: const ValueKey("mapWidget"),
        cameraOptions: CameraOptions(
          center: Point(coordinates: Position(-122.433135, 37.785160)),
          zoom: 14,
        ),
        styleUri: AppConstants.mapboxStyleID,
        onMapCreated: _onMapCreated,
        // onTapListener: (MapContentGestureContext c) {
        //   _addMarkerToMap(c.point.coordinates.lng, c.point.coordinates.lat);
        // },
      ),
    );
  }
}
