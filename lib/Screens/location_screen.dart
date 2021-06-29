import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mi_weather_card/utils/NetworkClass.dart';
import 'package:mi_weather_card/utils/constants.dart';
import 'package:mi_weather_card/utils/weather.dart';

import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final weatherInfo;

  LocationScreen({this.weatherInfo});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var tempinK;
  var cityName;
  var weatherIcon;
  var weatherMsg;
  var tempinC;
  WeatherModel _weatherModel = WeatherModel();

  void updateUi(dynamic weatherinfo) {
    setState(() {
      if (weatherinfo == null) {
        tempinC = 0;
        cityName = 'No Data Available';
        weatherIcon = '';
        weatherMsg = '';
      } else {
        tempinK = weatherinfo['main']['temp'];
        var condition = weatherinfo['weather'][0]['id'];
        tempinC = tempinK.ceil();
        cityName = weatherinfo['name'];

        weatherIcon = _weatherModel.getWeatherIcon(condition);
        weatherMsg = _weatherModel.getMessage(tempinC);

        print(tempinC);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.weatherInfo);
    updateUi(widget.weatherInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/weather.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // ignore: deprecated_member_use
                  FlatButton(
                    onPressed: () {
                      updateLocation();
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typeName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CityScreen()));
                      print(typeName);
                      if (typeName != null) {
                        getCityWeather(typeName);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$tempinC°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  " $weatherMsg  ${cityName}!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateLocation() async {
    await Geolocator.checkPermission().then((value) async {
      var position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // print('$latitude \n+ $longitude');
      var getWeatherResponse = jsonDecode(await NetworkingClass()
          .getWeather(position.latitude, position.longitude));
      updateUi(getWeatherResponse);
    });
  }

  void getCityWeather(String cityName) async {
    var getWeatherResponse =
        jsonDecode(await NetworkingClass().getCityWeather(cityName));
    updateUi(getWeatherResponse);
  }
}
