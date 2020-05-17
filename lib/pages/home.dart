import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:printershare/pages/mapHome.dart';
import 'package:printershare/pages/addListing.dart';
import 'package:printershare/pages/manage.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    MapHome(),
    Add(),
    Manage()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex = 0;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline),
                title: Text('Add')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.view_agenda),
                title: Text('Manage')
            )
          ],
          ),
    );
  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
