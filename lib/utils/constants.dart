import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

const kButtonTextStyle = TextStyle(
    fontSize: 40.0,
    fontFamily: 'Spartan MB',
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);


const kTextFieldTextStyle = InputDecoration( border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(2))),
    hintText: 'Enter City Name',
    hintStyle: TextStyle(
      color: Colors.black45,
    ),
    filled: true,
    fillColor: Colors.white,
    icon: Icon(
      Icons.location_city,
      color: Colors.white,
    ));
