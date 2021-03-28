import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Models/owner.dart';
import 'signIn.dart';
import '../../Services/firestore_service.dart';
import '../../Services/authorization.dart';
import '../../const.dart';
import 'package:provider/provider.dart';

class CreateOwner extends StatefulWidget {
  @override
  _CreateOwnerState createState() => _CreateOwnerState();
}

class _CreateOwnerState extends State<CreateOwner> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String givenCountry = "";
  String givenCity = "";
  List<DropdownMenuItem<String>> menuItems = List();
  String value1 = "";
  String value2 = "City";
  bool disableddropDown = true;
  String hintCountry = "Country";
  String givenRestaurantName, givenEmail, givenAdress, givenPassword;
  bool passwordSeen = true;

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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        backgroundColor: allBgColor,
        body: Center(
          child: Column(
            children: [
              buildHeader(context),
              buildCard(context),
              buildButton(context),
              buildPic()
            ],
          ),
        ),
      ),
    );
  }

  buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, bottom: 20, left: 15),
      child: Container(
        height: 110,
        width: 350,
        child: Row(
          children: [
            Text(
              "Create\nAccount",
              style: Theme.of(context).textTheme.headline6.copyWith(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.1,
                  color: crazyPurple),
            ),
          ],
        ),
      ),
    );
  }

  buildCard(BuildContext context) {
    return Container(
      height: 360,
      width: 350,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                onSaved: (newValue) => givenRestaurantName = newValue,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Cant be empty";
                  } else if (value.length > 25) {
                    return "Cant be longer than 25 characters";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "Restaurant Name/Market Name",
                    hintStyle: Theme.of(context).textTheme.bodyText1),
              ),
              TextFormField(
                onSaved: (newValue) => givenAdress = newValue,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Cant be empty";
                  } else if (value.length > 80) {
                    return "Cant be longer than 80 characters";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "Adress",
                    hintStyle: Theme.of(context).textTheme.bodyText1),
              ),
              TextFormField(
                onSaved: (newValue) => givenEmail = newValue,
                validator: (value) {
                  if (!value.contains("@")) {
                    return "Give valid email";
                  } else if (value.isEmpty) {
                    return "Cant be empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: Theme.of(context).textTheme.bodyText1),
              ),
              TextFormField(
                obscureText: passwordSeen,
                onSaved: (newValue) => givenPassword = newValue,
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            setState(() {
                              if (passwordSeen) {
                                passwordSeen = false;
                              } else {
                                passwordSeen = true;
                              }
                            });
                          });
                        },
                        child: Icon(Icons.remove_red_eye)),
                    hintText: "Password",
                    hintStyle: Theme.of(context).textTheme.bodyText1),
              ),
              dropDownButtons(),
              TextButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignIn())),
                child: Text(
                  "Already have account?",
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        decoration: TextDecoration.underline,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  dropDownButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DropdownButton<String>(
          iconEnabledColor: crazyPurple,
          style:
              Theme.of(context).textTheme.bodyText1.copyWith(color: textColor),
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
        DropdownButton<String>(
          iconEnabledColor: crazyPurple,
          iconDisabledColor: allBgColor,
          style:
              Theme.of(context).textTheme.bodyText1.copyWith(color: textColor),
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

  buildPic() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
        ),
        child: Container(
          height: 130,
          width: 130,
          child: SvgPicture.asset(
            "assets/images/newspaper.svg",
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  buildButton(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 35.0, top: 15),
          child: Align(
            alignment: Alignment.centerRight,
            child: ButtonTheme(
              minWidth: 50,
              height: 50,
              child: RaisedButton(
                  elevation: 8,
                  color: notWhite,
                  onPressed: () async {
                    givenCountry = value1;
                    givenCity = value2;

                    final _authService =
                        Provider.of<Authorization>(context, listen: false);
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      try {
                        Owner owner = await _authService.createUserWithMail(
                            givenEmail, givenPassword);
                        if (owner != null) {
                          await FirestoreService().createUser(
                            adress: givenAdress,
                            restaurantName: givenRestaurantName,
                            id: owner.id,
                            email: owner.email,
                            city: givenCity,
                            country: givenCountry,
                          );
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      } catch (hata) {
                        print("Hata $hata");
                      }
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0))),
            ),
          ),
        ),
      ],
    );
  }
}
