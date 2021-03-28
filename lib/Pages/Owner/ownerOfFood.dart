import 'package:flutter/material.dart';
import 'package:market/Models/food_item.dart';
import 'package:market/Models/owner.dart';
import 'package:provider/provider.dart';

import '../../Services/firestore_service.dart';
import '../../Services/authorization.dart';
import '../../const.dart';
import '../../list.dart';
import '../details.dart';

class OwnerPage extends StatefulWidget {
  @override
  _OwnerPageState createState() => _OwnerPageState();
}

class _OwnerPageState extends State<OwnerPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var tabController;
  String givenCountry = "";
  String givenCity = "";
  List<DropdownMenuItem<String>> menuItems = List();
  String value1 = "";
  String value2 = "City";
  bool disableddropDown = true;
  String hintCountry = "Country";
  String givenRestaurantName,
      givenFoodName,
      adressName,
      givenTime,
      givenCategories,
      givenAdress;
  int choosenIndex;
  var activeUserId;
  Owner owner;
  List<FoodItem> foods;

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
    activeUserId = Provider.of<Authorization>(context).activeUserId;
    return DefaultTabController(
      length: 2,
      child: FutureBuilder(
        future: FirestoreService().bringUser(activeUserId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          owner = snapshot.data;
          return buildScaffold(context);
        },
      ),
    );
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
        drawer: buildDrawer(context),
        key: _scaffoldKey,
        floatingActionButton: Container(
          height: 70,
          width: 70,
          child: FloatingActionButton(
            onPressed: addItemFunction,
            child: Icon(
              Icons.add,
              size: 38,
              color: crazyPurple,
            ),
            elevation: 5,
            backgroundColor: notWhite,
          ),
        ),
        appBar: AppBar(
          title: Text(
            "Owner",
            style: Theme.of(context).textTheme.headline2,
          ),
          centerTitle: true,
          bottom: TabBar(indicatorColor: Colors.white, tabs: [
            Tab(
              icon: Icon(Icons.file_copy),
              text: "My Items",
            ),
            Tab(
              icon: Icon(Icons.add),
              text: "Add Item",
            )
          ]),
        ),
        backgroundColor: allBgColor,
        body: TabBarView(
          children: [
            myItems(context),
            addItemCard(context),
          ],
        ));
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  owner.restaurantName,
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  owner.adress,
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(fontSize: 12),
                )
              ],
            ),
            decoration: BoxDecoration(color: lightPurple),
          ),
          ListTile(
            title: Text("Edit profile"),
            leading: Icon(Icons.edit),
          ),
          ListTile(
            title: Text("Log out"),
            leading: Icon(Icons.logout),
            onTap: () => Authorization().signOut(),
          )
        ],
      ),
    );
  }

  void addItemFunction() async {
    var activeUserId =
        Provider.of<Authorization>(context, listen: false).activeUserId;
    givenCountry = value1;
    givenCity = value2;
    try {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text("Item added sucessfully.")));
        await FirestoreService().createFoodItem(
            city: owner.city,
            country: owner.country,
            categories: givenCategories,
            foodName: givenFoodName,
            time: givenTime,
            publisherId: activeUserId,
            adress: owner.adress,
            ownerOfPlaceName: owner.restaurantName);
        setState(() {
          choosenIndex = null;
        });
      }
    } catch (error) {
      print("Error" + error.toString());
    }
  }

  myItems(BuildContext context) {
    return FutureBuilder(
        future: FirestoreService().bringOwnerFoods(activeUserId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          foods = snapshot.data;
          return buildListView();
        });
  }

  ListView buildListView() {
    return ListView.builder(
      itemCount: foods.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
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
                      owner.restaurantName,
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(fontSize: 15),
                    ),
                    Text(
                      owner.city,
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
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontSize: 16, color: Colors.grey.shade500),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    )
                  ],
                ),
                Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Icon(Icons.more_vert_sharp),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }

  addItemCard(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            height: 280,
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: notWhite,
            ),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                        height: 60,
                        width: 350,
                        child: TextFormField(
                          onSaved: (inputValue) => givenFoodName = inputValue,
                          validator: (inputValue) => validator(inputValue),
                          decoration: InputDecoration(
                              hintText: "Food name",
                              hintStyle: Theme.of(context).textTheme.bodyText1),
                        )),
                    Row(
                      children: [
                        Text("Available until:"),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            height: 50,
                            width: 100,
                            child: TextFormField(
                              onSaved: (inputValue) => givenTime = inputValue,
                              validator: (inputValue) =>
                                  validatorTime(inputValue),
                              decoration: InputDecoration(
                                  hintText: "Time",
                                  hintStyle:
                                      Theme.of(context).textTheme.bodyText1),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Categories:",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: food.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 7.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  choosenIndex = index;
                                });
                                givenCategories = foodCategoryNames[index];
                              },
                              child: Container(
                                height: 60,
                                width: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: notWhite,
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 5,
                                          color: choosenIndex == index
                                              ? crazyPurple
                                              : Colors.grey.shade600)
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image.asset(
                                    "assets/images/${food[index]}",
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String validator(value) {
    if (value.length > 25) {
      return "İt can't be more than 25 characters";
    } else if (value.isEmpty) {
      return "Can't be empty";
    }
  }

  String validatorAdress(value) {
    if (value.length > 80) {
      return "İt can't be more than 80 characters";
    } else if (value.isEmpty) {
      return "Can't be empty";
    }
  }

  validatorTime(String value) {
    if (value.length > 5) {
      return "Time can't be more than 5 characters";
    } else if (value.isEmpty) {
      return "Can't be empty";
    }
  }
}
