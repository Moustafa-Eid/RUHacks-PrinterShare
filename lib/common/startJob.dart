import 'dart:convert';


class StartJob {
  StartJob({this.name,this.address,this.cost,this.phoneNumber,this.email});

  String name;
  String address;
  String cost;
  String phoneNumber;
  String email;


  String createListing () {

    Map<String, dynamic> listing = {
      'owner' : this.name,
      'location' : this.address,
      'info' : this.phoneNumber,
      'email' : this.email,
      'price' : this.cost,
    };

    return jsonEncode(listing);
  }




}