import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class COODViewModel with ChangeNotifier{
  Position _position;
  Position get position => _position;

  void updatePosition(Position p){
    _position = p;
    notifyListeners();
  }
}

