import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mi_weather_card/Screens/location_screen.dart';
import 'package:mi_weather_card/utils/NetworkClass.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var latitude;
  var longitude;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadinginitData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitSquareCircle(
          size: 80.0,
          color: Colors.white,
        ),
      ),
    );
  }

  void loadinginitData() async {
    await Geolocator.checkPermission().then((value) async {
      var position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
      });
      // print('$latitude \n+ $longitude');
      var getWeatherResponse =
          jsonDecode(await NetworkingClass().getWeather(latitude, longitude));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(
          weatherInfo: getWeatherResponse,
        );
      }));
    });
  }
}
