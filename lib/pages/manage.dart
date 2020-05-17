import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:printershare/main.dart';
import 'dart:convert';


class Manage extends StatefulWidget {
  @override
  _ManageState createState() => _ManageState();
}



class _ManageState extends State<Manage> {
  List<Map<String, dynamic>> dataInput = List<Map<String, dynamic>>();
  List<String> products = List<String>();


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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Manage Listings'),
      ),
      backgroundColor: Colors.white,
      body: projectWidget(),
    );
  }
}
