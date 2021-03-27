import 'package:cloud_firestore/cloud_firestore.dart';

class FoodItem {
  final String id;
  final String foodName;
  final String time;
  final String categories;
  final String publisherId;
  final String foodCity;
  final String foodCountry;
  final String adress;
  final String restaurantName;

  FoodItem(
      {this.foodCity,
      this.foodCountry,
      this.adress,
      this.restaurantName,
      this.publisherId,
      this.id,
      this.foodName,
      this.time,
      this.categories});

  factory FoodItem.createFromDoc(DocumentSnapshot doc) {
    return FoodItem(
        restaurantName: doc.data()["ownerOfPlaceName"],
        adress: doc.data()["adress"],
        foodCountry: doc.data()["country"],
        foodCity: doc.data()["city"],
        publisherId: doc.data()["publisherId"],
        id: doc.id,
        foodName: doc.data()["foodName"],
        time: doc.data()["time"],
        categories: doc.data()["categories"]);
  }
}
