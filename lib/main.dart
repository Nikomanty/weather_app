import 'package:flutter/material.dart';
import './ui/home.dart';

void main(){
  runApp(new MaterialApp(
    title: "WeatherApp",
    home: Home(),
    theme: new ThemeData(
      backgroundColor: Colors.white,
      primaryColor: Colors.red,
      accentColor: Colors.redAccent,
    ),
  ));
}