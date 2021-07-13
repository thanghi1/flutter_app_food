import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_food/models/Productx.dart';
import 'package:flutter_app_food/service/Firestore_Service.dart';
import 'package:flutter_app_food/static.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
class ProductProvider extends ChangeNotifier{

  var uuid = Uuid();
  final firestoreService = FirestoreService();
  String _id, _image, _title, _description;
  int _price, _size, _color;
  int _quantity = 1;
  List<Product> _cart = [];
  List _pdQuatity = [];
  List _pdCart =[];
  //Getters
  String get id => _id;
  String get image => _image;
  String get title => _title;
  String get description => _description;
  //String get itemPdCart => _itemPdCart;
  int get color => _color;
  int get price => _price;
  int get size => _size;



  Stream<List<Product>> get products => firestoreService.getProducts();
  List<Product> get productCart => _cart;
  List get pdCart => _pdCart;
  List get pdQuantity => _pdQuatity;
  //Stream<List<Product>> get pdCart => .getProducts();


  //Function
  // addPdCart(Product product){
  //   _itemPdCart = product;
  //   notifyListeners();
  // }


  void plus(){
    _quantity++;
    notifyListeners();
  }
  void minus(){
    if(_quantity>1)
      {
        _quantity--;
        notifyListeners();
      }
  }
  loadProduct(Product product){
    if(products!= null){
      _id = product.id;
      _image = product.image;
      _title = product.title;
      _description = product.description;
      _color = product.color;
      _price = product.price;
      _size = product.size;
    }else{
      print('Khong co data');
    }
  }

  // Future<dynamic> _getpdCart() async {
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   List pdCart = _prefs.get("pdCartKey");
  //   return pdCart.length;
  // }

  // void foo() async{
  //   final _count = await _getpdCart();
  //   _i = _count;
  //   notifyListeners();
  // }
  void lala() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var pdCart = _prefs.getStringList("pdCartKey");
    var pdQuantity = _prefs.getStringList("pdQuantityKey");
    if(pdCart== null){
        _cart = [];
        _pdQuatity = [];
        notifyListeners();
    }else {
      var _a = PhotosList
          .fromJson(pdCart)
          .photos;
      _cart = _a;

      _pdQuatity = pdQuantity;
      notifyListeners();
    }
  }
  Future ClearPdCart() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var pdCart = _prefs.getStringList("pdCartKey");
    var _a = PhotosList
        .fromJson(pdCart)
        .photos;
    _cart = _a;
    _cart.clear();
    _prefs.setStringList("pdCartKey", []);
    _prefs.setStringList("pdQuantityKey", []);
    notifyListeners();
  }
  void RemoveItem(String id, int i, Product product) async{

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var pdCart = _prefs.getStringList("pdCartKey");
    var pdQuantity = _prefs.getStringList("pdQuantityKey");
    var _a = PhotosList
        .fromJson(pdCart)
        .photos;
    var _b = _cart.indexWhere((element) => element.id == id);
    print(_b);
    //pdQuantity.removeAt(_b);
    _cart = _a;
    //_cart.removeWhere((element) => element.id == id);
    String _c = jsonEncode(_cart);
    print(_c);
    //_prefs.setStringList("pdCartKey", pdCart);
    //_prefs.setStringList("pdQuantityKey", pdQuantity);
    //notifyListeners();
    
  }
}