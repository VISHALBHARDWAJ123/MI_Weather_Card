import 'package:flutter/material.dart';
import 'package:mi_weather_card/Screens/loading_screen.dart';
// @author : Vishal Bhardwaj
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    home: LoadingScreen(),
  ));
}
