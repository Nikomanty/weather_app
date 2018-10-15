import 'package:flutter/material.dart';
import './ui/city.dart';

void main(){
  runApp(new MaterialApp(
    title: "WeatherApp",
    home: City(),
    theme: new ThemeData(
      backgroundColor: Colors.blueGrey,
      primaryColor: Colors.blue,
      accentColor: Colors.blueAccent,
    ),
  ));
}