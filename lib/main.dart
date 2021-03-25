import 'package:flutter/material.dart';
import 'package:market/Pages/ownerOfFood.dart';

import 'Pages/chooseWay.dart';
import 'Pages/details.dart';
import 'Pages/login.dart';
import 'const.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Projem',
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontSize: 17,
            fontFamily: "Poppins",
            color: textColor,
          ),
          bodyText2: TextStyle(
              fontFamily: "Poppins",
              fontSize: 20,
              color: textColor,
              fontWeight: FontWeight.bold),
          headline1: TextStyle(
              fontFamily: "Poppins",
              fontSize: 20,
              color: miniHeaderColor,
              fontWeight: FontWeight.bold),
          headline2: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
          headline3: TextStyle(
              fontFamily: "Poppins",
              fontSize: 45,
              color: crazyPurple,
              letterSpacing: 0.1,
              fontWeight: FontWeight.bold),
          headline4: TextStyle(
              fontFamily: "Poppins",
              fontSize: 20,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.bold),
          headline5: TextStyle(
              fontFamily: "Poppins",
              fontSize: 30,
              color: notWhite,
              fontWeight: FontWeight.bold),
          headline6: TextStyle(
            fontFamily: "Poppins",
            fontSize: 33,
            color: crazyPurple,
          ),
        ),
        primaryColor: crazyPurple,
      ),
      home: Owner(),
    );
  }
}
