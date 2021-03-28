import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:market/Pages/Owner/createOwner.dart';
import '../../Models/owner.dart';
import '../../Services/firestore_service.dart';
import '../../Services/authorization.dart';
import '../../const.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String givenEmail, givenPassword;

  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool passwordSeen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: allBgColor,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            buildHeader(context),
            buildCard(context),
            buildButton(context),
            buildPic()
          ],
        ),
      ),
    );
  }

  buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, bottom: 20, left: 15),
      child: Container(
        height: 120,
        width: 350,
        child: Row(
          children: [
            Text(
              "Sign\nIn",
              style: Theme.of(context).textTheme.headline6.copyWith(
                  fontSize: 45,
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
      height: 230,
      width: 350,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextFormField(
                onSaved: (newValue) => givenEmail = newValue,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Cant be empty";
                  } else if (value.length > 25) {
                    return "Cant be longer than 25 characters";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "E-mail",
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
              TextButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateOwner())),
                  child: Text("Create Account",
                      style: Theme.of(context).textTheme.bodyText1))
            ],
          ),
        ),
      ),
    );
  }

  buildPic() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 200,
        width: 250,
        child: SvgPicture.asset(
          "assets/images/signIn.svg",
          fit: BoxFit.contain,
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
                    final _authService =
                        Provider.of<Authorization>(context, listen: false);
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      try {
                        await _authService.signInWithMail(
                            givenEmail, givenPassword);
                        Navigator.pop(context);
                      } catch (hata) {
                        print("Hata $hata");
                      }
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: crazyPurple,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0))),
            ),
          ),
        ),
      ],
    );
  }
}
