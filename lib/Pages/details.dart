import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:market/Models/food_item.dart';
import 'package:market/Models/owner.dart';
import 'package:market/Services/firestore_service.dart';

import '../const.dart';

class Home extends StatefulWidget {
  final givenCity;
  final givenCountry;

  const Home({Key key, this.givenCity, this.givenCountry}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<FoodItem> foods;
  String choosenAdress;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: allBgColor,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                builAdresssCard(context),
                buildMiniHeader(context),
                buildListView(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget builAdresssCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35.0),
      child: Container(
        height: 360,
        width: 350,
        decoration: BoxDecoration(
          color: notWhite,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    color: crazyPurple,
                    size: 36,
                  ),
                  Text(
                    "Adress",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(right: 40.0, left: 10),
                  child: Text(
                    choosenAdress == null
                        ? "Choose card to see adress"
                        : choosenAdress,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: crazyPurple, fontSize: 15),
                  ),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Container(
                      height: 100,
                      width: 200,
                      child: SvgPicture.asset(
                        "assets/images/location.svg",
                        fit: BoxFit.contain,
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildMiniHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 15),
      child: Row(
        children: [
          Icon(
            Icons.fastfood,
            size: 30,
            color: crazyPurple,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "Restaurants",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: crazyPurple, fontSize: 23),
          )
        ],
      ),
    );
  }

  buildListView(BuildContext context) {
    return FutureBuilder(
        future: FirestoreService().bringFoodsAccToCity(widget.givenCity),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          foods = snapshot.data;

          return buildPadding();
        });
  }

  Padding buildPadding() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        height: 280,
        child: ListView.builder(
          itemCount: foods.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    return choosenAdress = foods[index].adress;
                  });
                },
                child: Container(
                  height: 150,
                  width: 250,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      blurRadius: 5,
                    ),
                  ], borderRadius: BorderRadius.circular(20), color: notWhite),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              height: 60,
                              width: 60,
                              child: Image.asset(
                                "assets/images/${foods[index].categories}.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            foods[index].foodName,
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            foods[index].foodCity,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Text(
                            foods[index].restaurantName,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: lightPurple),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 80,
                              ),
                              Text(
                                "Available until " + foods[index].time,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                        fontSize: 16,
                                        color: Colors.grey.shade500),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
