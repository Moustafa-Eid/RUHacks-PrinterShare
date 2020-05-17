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
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS




  Future<List<Map>> getData() async {
    List<Map> dataIncoming = List<Map>();
    final response = await http.get('https://us-central1-ruhacks2020-f7a7e.cloudfunctions.net/getJobs');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(json.decode(response.body));
      await json.decode(response.body).forEach((k,v) => dataIncoming.add(v));
      return dataIncoming;
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
            String project = projectSnap.data[index]['product'];
            return Card(
              child: ListTile(
                contentPadding: EdgeInsets.all(10.0),
                onTap: () {},
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text('Distance'),
                        Icon(Icons.location_on),
                      ],
                    ),
                    Text('\$${projectSnap.data[index]['price']}'),
                    Container(
                      padding: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.call,
                          color: Colors.white,),
                          Text("Contact",
                          style: TextStyle(
                            color: Colors.white,
                          ),)
                        ],
                      ),
                    )
                  ],
                ),
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
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width/1.1,
        height: 40,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.arrow_drop_up),
              Text('Header'),
            ],
          ),
        ),
      ),
      expandableContent: Container(
        height: 500,
        width: MediaQuery.of(context).size.width/1.1,
        color: Colors.grey[300],
        child: projectWidget(),
      ),
    );
  }
}
