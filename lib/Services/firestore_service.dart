import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market/Models/food_item.dart';
import 'package:market/Models/owner.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createFoodItem(
      {publisherId,
      ownerOfPlaceName,
      foodName,
      adress,
      time,
      categories,
      id,
      city,
      country}) async {
    await _firestore.collection("foodItems").doc(id).set({
      "publisherId": publisherId,
      "ownerOfPlaceName": ownerOfPlaceName,
      "foodName": foodName,
      "adress": adress,
      "time": time,
      "categories": categories,
      "city": city,
      "country": country
    });
  }

  Future<void> createUser(
      {id, email, country, city, restaurantName, adress}) async {
    await _firestore.collection("owners").doc(id).set({
      "adress": adress,
      "restaurantName": restaurantName,
      "email": email,
      "country": country,
      "city": city,
      "id": id,
    });
  }

  Future<Owner> bringUser(id) async {
    DocumentSnapshot doc = await _firestore.collection("owners").doc(id).get();
    if (doc.exists) {
      Owner owner = Owner.createFromDoc(doc);
      print("Owner " + owner.id);
      return owner;
    }

    return null;
  }

  bringOwnerFoods(id) async {
    var snapshot = await _firestore
        .collection("foodItems")
        .where("publisherId", isEqualTo: id)
        .get();
    var foods =
        snapshot.docs.map((doc) => FoodItem.createFromDoc(doc)).toList();

    return foods;
  }

  bringFoodsAccToCity(cityName) async {
    var snapshot = await _firestore
        .collection("foodItems")
        .where("city", isEqualTo: cityName)
        .get();
    var foods =
        snapshot.docs.map((doc) => FoodItem.createFromDoc(doc)).toList();

    return foods;
  }
}
