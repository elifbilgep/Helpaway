import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createFoodItem(
      {publisherId,ownerOfPlaceName,
      foodName,
      adress,
      time,
      categories,
      id,
      city,
      country}) async {
    await _firestore.collection("foodItems").doc(id).set({
      "publisherId" : publisherId,
      "ownerOfPlaceName": ownerOfPlaceName,
      "foodName": foodName,
      "adress": adress,
      "time": time,
      "categories": categories,
      "city": city,
      "country": country
    });
  }

  Future<void> createUser({
    id,
    email,
    country,
    city,

  }) async {
    await _firestore.collection("owners").doc(id).set({
      "email": email,
      "country": country,
      "city": city,
      "id": id,
    });
  }

  
  
}
