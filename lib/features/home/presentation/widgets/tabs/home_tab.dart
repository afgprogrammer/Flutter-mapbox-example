import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as flutter_widgets;
import 'package:mapbox_example/app/constants.dart';
import 'package:mapbox_example/shared/inputs/base_input.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late MapboxMap mapboxMap;
  String? foundPlaceName;
  bool isLoading = false;

    // debounce
  Timer? _debounce;
  final Duration _debounceDuration = const Duration(milliseconds: 500);

  String mapboxToken = AppConstants.mapboxToken;

  Future<void> _onMapCreated(MapboxMap createdMap) async {
    MapboxOptions.setAccessToken(mapboxToken);
    mapboxMap = createdMap;
  }

  Future<void> _searchLocation(String query) async {
    if (query.isEmpty) return;

    setState(() {
      isLoading = true;
    });

    // Example Mapbox forward geocoding request:
    final url = Uri.parse(
      "https://api.mapbox.com/geocoding/v5/mapbox.places/$query.json?access_token=$mapboxToken"
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["features"] != null && data["features"].isNotEmpty) {
        final feature = data["features"][0];
        final placeName = feature["place_name"];
        final coords = feature["geometry"]["coordinates"];
        final lng = coords[0];
        final lat = coords[1];

        // Move camera to this location
        mapboxMap.flyTo(
          CameraOptions(
            center: Point(coordinates: Position(lng, lat)),
            zoom: 14,
          ),
          MapAnimationOptions(duration: 1000),
        );

        // Show marker at this location
        // _addMarkerToMap(lng, lat);
        setState(() {
          foundPlaceName = placeName;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Found: $placeName"))
        );
      }
    }

    setState(() {
      isLoading = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BaseInput(
          hint: "Search for a place",
          prefixIcon: Container(
            height: 20,
            width: 20,
            padding: isLoading ? EdgeInsets.all(16) : EdgeInsets.all(0),
            child: isLoading ? CircularProgressIndicator(
              color: Colors.black,
              strokeWidth: 2,
            ) : Center(child: Icon(Icons.search, color: Colors.black)),
          ),
          onChanged: (value) {
            // debounce calls
            _debounce?.cancel();
            _debounce = Timer(_debounceDuration, () {
              _searchLocation(value);
            });
          },
        ),
          bottom: PreferredSize(
          preferredSize: const flutter_widgets.Size.fromHeight(8),
          child: Container(
            height: 0,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
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
      ),
    );
  }
}
