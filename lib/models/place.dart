import 'dart:io';

import 'package:flutter/foundation.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  PlaceLocation({
    //required Key?key,
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

class Place {
  final String id;
  final String title;
  //final PlaceLocation location;
  final File image;




  Place({
    //required Key? key,
    required this.id,
    required this.title,
     //required this.location,
    required this.image,
  });
}
