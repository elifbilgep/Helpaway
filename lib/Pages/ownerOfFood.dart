import 'package:flutter/material.dart';
import 'package:market/const.dart';

import '../list.dart';

class Owner extends StatefulWidget {
  @override
  _OwnerState createState() => _OwnerState();
}

class _OwnerState extends State<Owner> {
  var tabController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
              addItem(context),
            ],
          )),
    );
  }

  myItems(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
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
                          "assets/images/soup.png",
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
                      "Mercimek Soup",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Tostçu Erol",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      "Karşıyaka",
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
                          "Avaiable until 9 am",
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

  addItem(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            height: 370,
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: notWhite,
            ),
            child: Form(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Container(
                        height: 60,
                        width: 350,
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: "Restaurant name",
                              hintStyle: Theme.of(context).textTheme.bodyText1),
                        )),
                    Container(
                        height: 60,
                        width: 350,
                        child: TextFormField(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: notWhite,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5, color: Colors.grey.shade500)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset(
                              "assets/images/tray.png",
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: notWhite,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5, color: Colors.grey.shade500)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset(
                              "assets/images/soup.png",
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: notWhite,
                              boxShadow: [
                                BoxShadow(blurRadius: 5, color: crazyPurple)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset(
                              "assets/images/bread.png",
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: notWhite,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5, color: Colors.grey.shade500)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset(
                              "assets/images/dessert.png",
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
