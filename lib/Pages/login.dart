import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:market/Pages/Owner/signIn.dart';
import 'Owner/ownerOfFood.dart';
import '../const.dart';
import 'Owner/createOwner.dart';
import 'chooseWay.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final String assetName = "assets/images/city_svg.svg";

  String givenCountry = "";
  String givenCity = "";
  List<DropdownMenuItem<String>> menuItems = List();
  String value1 = "";
  String value2 = "City";
  bool disableddropDown = true;
  String hintCountry = "Country";

  final turkey = {
    "1": "İzmir",
    "2": "Ankara",
    "3": "İstanbul",
  };
  final america = {
    "1": "Georgia",
    "2": "Hawaii",
    "3": "Minnesota",
  };
  final england = {
    "1": "Bristol",
    "2": "London",
    "3": "Oxford",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: allBgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildHeader(context),
          buildCard(context),
          buildButtons(context),
          buildImage(context),
        ],
      ),
    );
  }

  Widget buildHeader(context) {
    return Center(
      child: Container(
        height: 150,
        width: 350,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Helpaway",
              style: Theme.of(context).textTheme.headline3,
            ),
          ],
        ),
      ),
    );
  }

  buildCard(BuildContext context) {
    return Container(
      height: 250,
      width: 350,
      decoration: BoxDecoration(
          color: notWhite,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.grey.shade800, blurRadius: 5)]),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Choose your country",
              style: Theme.of(context).textTheme.headline4,
            ),
            DropdownButton<String>(
              iconEnabledColor: crazyPurple,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: textColor),
              hint: Text(hintCountry),
              items: [
                DropdownMenuItem<String>(
                  value: "Turkey",
                  child: Text(
                    "Turkey",
                  ),
                ),
                DropdownMenuItem<String>(
                  value: "America",
                  child: Text("America"),
                ),
                DropdownMenuItem<String>(
                  value: "England",
                  child: Text("England"),
                ),
              ],
              onChanged: (_value) {
                selected(_value);
              },
            ),
            Text(
              "Choose your city",
              style: Theme.of(context).textTheme.headline4,
            ),
            DropdownButton<String>(
              iconEnabledColor: crazyPurple,
              iconDisabledColor: allBgColor,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: textColor),
              hint: Text(value2),
              items: menuItems,
              onChanged: disableddropDown
                  ? null
                  : (_value) {
                      setState(() {
                        value2 = _value;
                      });
                    },
              disabledHint: Text("City"),
            ),
          ],
        ),
      ),
    );
  }

  void selected(String _value) {
    if (_value == "Turkey") {
      menuItems = [];
      populateTurkey();
    } else if (_value == "America") {
      menuItems = [];
      populateAmerica();
    } else if (_value == "England") {
      menuItems = [];
      populateEngland();
    }
    setState(() {
      hintCountry = _value;
      value1 = _value;
      disableddropDown = false;
    });
  }

  void populateTurkey() {
    for (String key in turkey.keys) {
      menuItems.add(DropdownMenuItem<String>(
        child: Center(
          child: Text(turkey[key]),
        ),
        value: turkey[key],
      ));
    }
  }

  void populateAmerica() {
    for (String key in america.keys) {
      menuItems.add(DropdownMenuItem<String>(
        child: Center(
          child: Text(america[key]),
        ),
        value: america[key],
      ));
    }
  }

  void populateEngland() {
    for (String key in england.keys) {
      menuItems.add(DropdownMenuItem<String>(
        child: Center(
          child: Text(england[key]),
        ),
        value: england[key],
      ));
    }
  }

  buildButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
      child: Container(
        height: 120,
        width: 400,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonTheme(
              minWidth: 200,
              height: 50,
              child: RaisedButton(
                  elevation: 8,
                  color: notWhite,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignIn()));
                  },
                  child: Text(
                    "Owner of business?",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(fontSize: 16),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0))),
            ),
            SizedBox(
              width: 15,
            ),
            ButtonTheme(
              minWidth: 50,
              height: 50,
              child: RaisedButton(
                  elevation: 8,
                  color: notWhite,
                  onPressed: () {
                    givenCountry = value1;
                    givenCity = value2;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Choose(
                            givenCity: givenCity,
                            givenCountry: givenCountry,
                          ),
                        ));
                  },
                  child: Icon(Icons.arrow_forward_ios),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0))),
            )
          ],
        ),
      ),
    );
  }

  buildImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
          height: 150,
          width: 350,
          child: SvgPicture.asset(
            "assets/images/city_svg.svg",
            fit: BoxFit.cover,
          )),
    );
  }
}
