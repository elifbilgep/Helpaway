import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:market/Pages/details.dart';
import '../const.dart';

class Choose extends StatelessWidget {
  final givenCountry;
  final givenCity;
  String foodText = "Shows restaurants that give away food nearby.";
  String market =
      "Shows supermarkets that are eager to prevent waste of products nearby.";

  Choose({Key key, this.givenCountry, this.givenCity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: allBgColor,
        body: Center(
          child: Column(
            children: [
              buildHeader(context),
              buildCards(context),
            ],
          ),
        ),
      ),
    );
  }

  buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, bottom: 20),
      child: Container(
        width: 350,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "What do you need?",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(shadows: <Shadow>[
                Shadow(
                    offset: Offset(0, 2),
                    blurRadius: 3.0,
                    color: Colors.grey.shade500),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  buildCards(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 550,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 550,
              width: MediaQuery.of(context).size.width / 2.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    blurRadius: 5,
                  )
                ],
                color: notWhite,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  SvgPicture.asset(
                    "assets/images/hamburger.svg",
                    height: 130,
                    width: 130,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      foodText,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  SizedBox(
                    height: 55,
                  ),
                  ButtonTheme(
                    height: 40,
                    minWidth: 130,
                    child: RaisedButton(
                        child: Text(
                          "Show",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home(givenCity:givenCity,givenCountry:givenCountry)));
                        },
                        color: prettyPurple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0))),
                  )
                ],
              ),
            ),
            Container(
              height: 550,
              width: MediaQuery.of(context).size.width / 2.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    blurRadius: 5,
                  )
                ],
                color: notWhite,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  SvgPicture.asset(
                    "assets/images/shopping.svg",
                    height: 130,
                    width: 130,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      foodText,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  SizedBox(
                    height: 55,
                  ),
                  ButtonTheme(
                    height: 40,
                    minWidth: 130,
                    child: RaisedButton(
                        child: Text(
                          "Show",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        onPressed: () {},
                        color: prettyPurple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0))),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
