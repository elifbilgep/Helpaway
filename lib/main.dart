import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Pages/Owner/createOwner.dart';
import 'Pages/details.dart';
import 'Pages/login.dart';
import 'Services/authorization.dart';
import 'Services/redirecting.dart';
import 'const.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Authorization().signOut();
    return Provider<Authorization>(
      create: (_) => Authorization(),
      child: MaterialApp(
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
        home: Redirecting(),
      ),
    );
  }
}
