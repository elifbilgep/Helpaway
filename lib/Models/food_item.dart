import 'package:cloud_firestore/cloud_firestore.dart';

class FoodItem {
  final String id;
  final String foodName;
  final String time;
  final String categories;
  final String publisherId;

  FoodItem(
      {this.publisherId, this.id, this.foodName, this.time, this.categories});

  factory FoodItem.createFromDoc(DocumentSnapshot doc) {
    return FoodItem(
        publisherId: doc.data()["publisherId"],
        id: doc.id,
        foodName: doc.data()["foodName"],
        time: doc.data()["time"],
        categories: doc.data()["categories"]);
  }
}
