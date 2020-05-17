import 'package:flutter/material.dart';
import 'package:printershare/common/startJob.dart';
import 'package:http/http.dart' as http;


class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}



class _AddState extends State<Add> {
  TextEditingController _controllerName = new TextEditingController();
  TextEditingController _controllerAddress = new TextEditingController();
  TextEditingController _controllerCost = new TextEditingController();
  TextEditingController _controllerPhone = new TextEditingController();
  TextEditingController _controllerEmail = new TextEditingController();

  void sendData(String title, dynamic jsonfile) {
    http.post('https://jsonplaceholder.typicode.com/albums',
      body: jsonfile,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Add a New Listing'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _controllerName,
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(),
                hintText: 'Full Name:',
              ),
            ),
          ),
          Flexible(
            child: TextField(
              controller: _controllerAddress,
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(),
                hintText: 'Address:',
              ),
            ),
          ),
          Flexible(
            child: TextField(
              controller: _controllerCost,
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(),
                hintText: 'Cost/hr:',
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Flexible(
            child: TextField(
              controller: _controllerPhone,
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(),
                hintText: 'Phone Number',
              ),
            ),
          ),
          Flexible(
            child: TextField(
              controller: _controllerEmail,
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(),
                hintText: 'Email:',
              ),
            ),
          ),
          RaisedButton.icon(
            onPressed: () {
              StartJob instance = StartJob(name: _controllerName.text,address: _controllerAddress.text,cost: _controllerCost.text,phoneNumber: _controllerPhone.text,email: _controllerEmail.text);
              sendData('https://us-central1-ruhacks2020-f7a7e.cloudfunctions.net/addJob', instance.createListing());
            },
            icon: Icon(Icons.done,size: 35.0,color: Colors.white,),
            label: Text(
              'Add Listing',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
            color: Colors.blue,
            shape: StadiumBorder(),
          ),
        ],
      ),
    );
  }
}
