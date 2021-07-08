import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_food/models/Productx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  //Get
  Stream<List<Product>> getProducts(){
    return _db
        .collection('product')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Product.fromJson(doc.data()))
        .toList());
  }

  //Add

}
