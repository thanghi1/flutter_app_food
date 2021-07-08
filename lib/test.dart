
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/Productx.dart';
final productref = FirebaseFirestore.instance.collection('product');

class test extends StatefulWidget {
  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {
  @override
  void initState() {
    // TODO: implement initState
    // getProduct();
    _getpdCart();
    super.initState();


  }
  getProduct(){
    productref.get().then((QuerySnapshot snapshot) => snapshot.docs.forEach((DocumentSnapshot doc) {
      print(doc.data());
    }));
  }
  Future<dynamic> _getpdCart() async {

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final pdCart = _prefs.getStringList("pdCartKey");
    final pdQuality = _prefs.getStringList("pdQualityKey");
    // print(jsonDecode(pdCart)); // String Json
    // print(pdCart); // String
    if(pdCart == null) return print('no data');
    else return print(pdQuality);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('123'),),
    );
  }
}
