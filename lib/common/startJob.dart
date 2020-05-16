import 'dart:convert';


class StartJob {
  StartJob({this.name,this.address});

  String name;
  String address;
  double cost;
  int numPrintersAvailable;
  String phoneNumber;
  String email;


  String createListing () {

    Map<String, dynamic> listing = {
      'name' : this.name,
      'address' : this.address,
      'phone' : this.phoneNumber,
      'email' : this.email,
      'cost' : this.cost,
      'numPrinters' : this.numPrintersAvailable
    };

    return jsonEncode(listing);
  }




}