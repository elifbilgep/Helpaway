import 'package:flutter/material.dart';
import 'package:market/Pages/Owner/signIn.dart';
import '../Models/owner.dart';
import '../Pages/login.dart';
import '../Pages/Owner/ownerOfFood.dart';
import '../const.dart';
import 'package:provider/provider.dart';
import 'authorization.dart';

class Redirecting extends StatefulWidget {
  @override
  _RedirectingState createState() => _RedirectingState();
}

class _RedirectingState extends State<Redirecting> {
  String _activeUserId;

  @override
  Widget build(BuildContext context) {
    _activeUserId = Provider.of<Authorization>(context).activeUserId;
    final _authService = Provider.of<Authorization>(context, listen: false);
    return StreamBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
            backgroundColor: allBgColor,
          )));
        } else if (snapshot.hasData) {
          Owner activeUser = snapshot.data;
          _authService.activeUserId = activeUser.id;
          return OwnerPage();
        } else {
          return LoginPage();
        }
      },
      stream: _authService.stateFollower,
    );
  }
}
