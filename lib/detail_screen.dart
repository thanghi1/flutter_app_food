import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_food/Provider/Product.dart';
import 'package:flutter_app_food/cart.dart';
import 'package:flutter_app_food/my_flutter_app_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/Productx.dart';
import 'my_flutter_app_icons.dart';
import 'static.dart';

class DetailProduct extends StatelessWidget {
  final Product product;

  const DetailProduct({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Provide total width and heght
    Size size = MediaQuery.of(context).size;

    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      backgroundColor: Color(product.color),
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            iconSize: 30,
            onPressed: () => Navigator.pop(context)),
        actions: [
          IconButton(
            icon: Icon(Icons.search_rounded),
            color: Colors.white,
            iconSize: 30,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Colors.white,
            iconSize: 30,
            onPressed: () {
              // Provider.of<ProductProvider>(context, listen: false).foo();
              Provider.of<ProductProvider>(context, listen: false).lala();
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cart()));
            },
          ),
          SizedBox(
            width: 15,
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.35),
                    padding: EdgeInsets.only(top: size.height * 0.1, left: 30),
                    //height: 500,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        )),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 30, right: 25),
                                      width: size.width * 0.6,
                                      child: Text(
                                        product.description,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 15),
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(color: Colors.black),
                                        children: [
                                          TextSpan(text: 'Size\n'),
                                          TextSpan(
                                              style: TextStyle(
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.bold),
                                              text: product.size.toString() +
                                                  ' cm'),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            // Quantity(),
                            Padding(padding: EdgeInsets.only(top: 20)),
                            Row(
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    _savePdCart(product);
                                    Cart(product: product);

                                    //_deletePdCart();
                                    // print(jsonProduct);
                                    // print(product.toMap());
                                  },
                                  child: Icon(
                                    Icons.add_shopping_cart,
                                    color: Colors.black,
                                  ),
                                  style: OutlinedButton.styleFrom(
                                      minimumSize: Size(100.0, 55.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0)),
                                      side: BorderSide(width: 0.1)),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                ElevatedButton.icon(
                                    onPressed: null,
                                    icon: Icon(
                                      MyFlutterApp.dollar,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                    style: ButtonStyle(
                                        padding:
                                            MaterialStateProperty.all<EdgeInsets>(
                                                EdgeInsets.only(
                                                    top: 20,
                                                    bottom: 20,
                                                    left: 70,
                                                    right: 70)),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.green),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0)))),
                                    label: Text(
                                      'Buy Now',
                                      style: TextStyle(color: Colors.white),
                                    ))
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hand Bag',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          product.title,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Price\n',
                                      style: TextStyle(
                                        color: Colors.white70,
                                      )),
                                  TextSpan(
                                      text: '\$${product.price}',
                                      style: TextStyle(
                                          fontSize: 35,
                                          fontWeight: FontWeight.w700))
                                ],
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                                child: Hero(
                                    tag: "${product.id}",
                                    child: Image.asset(
                                      product.image,
                                      fit: BoxFit.fill,
                                    ))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _savePdCart(Product product) async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final pdQuantity = _prefs.getStringList("pdQuantityKey")??[];
    final pdCart = _prefs.getStringList("pdCartKey")??[]; //Get String List = Key. Nếu Null thì gán = [];

    final Map<String, dynamic> _mapProduct = product.FromInstanceToJsonString(product); //Parse Instance of Product sang dạng Json Map

    int strQuantity = 1;
    String jsonProduct = jsonEncode(_mapProduct); //Mã hóa dữ liệu Json thành dạng String
    if(!pdCart.any((element) => element.contains(product.id))){
      pdCart.add(jsonProduct);
      pdQuantity.add(strQuantity.toString());
    }
    else{
      print('San pham nay da co trong danh sach roi, so luong +1');
      var IndexOfItemWhereId = pdCart.indexWhere((element) => element.contains(product.id));
      int _a, _b;
      _a = int.parse(pdQuantity[IndexOfItemWhereId]);
      _b = _a + 1;
      pdQuantity[IndexOfItemWhereId] = _b.toString();
      // print(pdQuantity[IndexOfItemWhereId]);

    }


    // pdCart.firstWhere((element) => element.contains(product.id));
    // _a.update("quantity", (dynamic value) => ++value);
    _prefs.setStringList("pdCartKey", pdCart); //Lưu lại
    _prefs.setStringList("pdQuantityKey", pdQuantity);
    // print(pdCart);
    print(pdQuantity);


  }
  
  Future _deletePdCart() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var _a =_prefs.getStringList("pdQuantityKey");
    var _b = _prefs.getStringList("pdCartKey");
    print(_a);
    print(_b);
    
    _prefs.remove("pdCartKey");
    _prefs.remove("pdQuantityKey");
  }



}

class DotWidget extends StatelessWidget {
  final color;
  final bool isSelected;

  const DotWidget({
    Key key,
    this.color,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, right: 10),
      padding: EdgeInsets.all(3),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
          )),
      child: DecoratedBox(
          decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
    );
  }
}




