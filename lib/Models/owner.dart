import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Owner {
  final String id;
  final String country;
  final String city;
  final String adress;
  final String email;
  final String restaurantName;

  Owner(
      {this.restaurantName,
      this.email,
      this.id,
      this.country,
      this.city,
      this.adress});

  factory Owner.createFromFirebase(User user) {
    return Owner(
      id: user.uid,
      email: user.email,
    );
  }
  factory Owner.createFromDoc(DocumentSnapshot doc) {
    return Owner(
        id: doc.id,
        city: doc.data()["city"],
        country: doc.data()["country"],
        adress: doc.data()["adress"],
        restaurantName: doc.data()["restaurantName"]);
  }
}
