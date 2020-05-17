import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class MapHome extends StatefulWidget {
  @override
  _MapHomeState createState() => _MapHomeState();
}

class _MapHomeState extends State<MapHome> {
  Completer<GoogleMapController> _controller = Completer();
  static LatLng _initialPosition;
  static LatLng _lastMapPosition = _initialPosition;
  bool done = false;



  Future<List<String>> getData() async {
    List<String> products = List<String>();
    final response = await http.get('https://us-central1-ruhacks2020-f7a7e.cloudfunctions.net/getJobs');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      await json.decode(response.body).forEach((k,v) => products.add(v['product']));
      return products;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Widget projectWidget() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container();
        }
        return projectSnap.data != null ? ListView.builder(
          itemCount: projectSnap.data.length,
          itemBuilder: (context, index) {
            String project = projectSnap.data[index];
            return Card(
              child: ListTile(
                contentPadding: EdgeInsets.all(10.0),
                onTap: () {},
                title: Text('$project'),
              ),
            );
          },
        ) : SizedBox();
      },
      future: getData(),
    );
  }

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  void _getUserLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      print('${placemark[0].name}');
    });
    done = true;
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableBottomSheet(
      background:  _initialPosition == null
          ? Container(
        color: Colors.white,
        child: Center(
          child: Text(
            'loading map..',
            style: TextStyle(
                fontFamily: 'Avenir-Medium', color: Colors.grey[400]),
          ),
        ),
      )
          : Container(
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: _initialPosition,
                  zoom: 14.4746,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                zoomControlsEnabled: false,
                zoomGesturesEnabled: true,
                myLocationEnabled: true,
              )
            ],
          ),
        ),
      ),
      persistentHeader: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
          color: Colors.blue,
        ),
        width: MediaQuery.of(context).size.width/1.1,
        height: 40,
        child: Center(
          child: Text('Header'),
        ),
      ),
      expandableContent: Container(
        height: 500,
        width: MediaQuery.of(context).size.width/1.1,
        color: Colors.green,
        child: projectWidget(),
      ),
    );
  }
}
