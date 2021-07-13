import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_food/Provider/Product.dart';
import 'package:flutter_app_food/models/Productx.dart';
import 'package:flutter_app_food/static.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'detail_screen.dart';

class Cart extends StatelessWidget {
  final Product product;

  const Cart({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    final productProvider = Provider.of<ProductProvider>(context);
    print('Product ' + '${product}');

    return productProvider.productCart.isEmpty
        ? Scaffold(
            appBar: AppBar(
              title: Text('Cart Screen'),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                iconSize: 30,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Center(
              child: Text('Chua co Data gio hang'),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Cart Screen'),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                iconSize: 30,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Center(
              child: ListView.builder(
                  itemCount: productProvider.productCart.length,
                  itemBuilder: (context, index) => Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ItemCart(
                              product: productProvider.productCart[index],
                              index: index,
                            )
                          ],
                        ),
                      )),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () =>
                    productProvider
                        .ClearPdCart()),
          );
  }
}

class ItemCart extends StatelessWidget {
  final Product product;
  int index;

  ItemCart({Key key, this.product, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 2.0)),
      margin: EdgeInsets.only(top: 20),
      width: 350,
      height: 150,
      //color: Colors.blue,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(product.color),
                        border: Border.all(width: 1.0),
                        borderRadius: BorderRadius.circular(16)),
                    child: FittedBox(
                      child: Image.asset(product.image),
                    ),
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Container(
                    //color: Colors.brown,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(product.title),
                        Text(product.color.toString()),
                        Text('\$' + '${product.price}')
                      ],
                    ),
                  ),
                  flex: 3,
                ),
                Expanded(
                    child: Row(
                      children: [
                        IconButton(icon: Icon(Icons.delete), onPressed: () {
                          productProvider.RemoveItem(product.id, index, product);
                        },)
                      ],
                    ),
                  flex: 1,
                )
              ],
            ),
            flex: 4,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Counter(
                  index: index,
                  product: product,
                ),
              ],
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}

class Counter extends StatefulWidget {
  final index;
  final Product product;

  const Counter({Key key, this.index, this.product}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  String i;

  CongQuanlity() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final pdQuantity = _prefs.getStringList("pdQuantityKey");
    final pdCart = _prefs.getStringList("pdCartKey");
    var IndexOfItemWhereId =
        pdCart.indexWhere((element) => element.contains(widget.product.id));
    int _a, _b;
    _a = int.parse(pdQuantity[IndexOfItemWhereId]);
    _b = _a + 1;

    pdQuantity[IndexOfItemWhereId] = _b.toString();
    _prefs.setStringList("pdQuantityKey", pdQuantity);
    setState(() {
      i = pdQuantity[IndexOfItemWhereId];
    });
    print(pdQuantity);
  }

  TruQuanlity() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final pdQuantity = _prefs.getStringList("pdQuantityKey");
    final pdCart = _prefs.getStringList("pdCartKey");
    var IndexOfItemWhereId =
        pdCart.indexWhere((element) => element.contains(widget.product.id));
    int _a, _b;
    _a = int.parse(pdQuantity[IndexOfItemWhereId]);
    if (_a > 2) {
      _b = _a - 1;
    }

    pdQuantity[IndexOfItemWhereId] = _b.toString();
    _prefs.setStringList("pdQuantityKey", pdQuantity);
    setState(() {
      i = pdQuantity[IndexOfItemWhereId];
    });
    print(pdQuantity);
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    print('${productProvider.pdQuantity[widget.index]}' + 'So luong');
    return Row(
      children: [
        SizedBox(
          width: 40,
          height: 32,
          child: OutlinedButton(
            onPressed: () {
              TruQuanlity();
            },
            child: Icon(Icons.remove),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            //Định dạng số 01 02 03 ... 09 sử dụng .padLeft(2,"0")
            child: Text(
              i != null
                  ? '${i}'.padLeft(2, "0")
                  : '${productProvider.pdQuantity[widget.index]}'
                      .padLeft(2, "0"),
              style: TextStyle(fontSize: 20),
            )),
        SizedBox(
          width: 40,
          height: 32,
          child: OutlinedButton(
            onPressed: () {
              CongQuanlity();
            },
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}

Future _deletePdCart() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  var _a = _prefs.getStringList("pdQuantityKey");
  var _b = _prefs.getStringList("pdCartKey");
  print(_a);
  print(_b);

  _prefs.remove("pdCartKey");
  _prefs.remove("pdQuantityKey");
}

// child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(border: Border.all(width: 2.0)),
//                         margin: EdgeInsets.only(top: 20),
//                         width: 350,
//                         height: 150,
//                         //color: Colors.blue,
//                         child: Column(
//                           children: [
//                             Expanded(
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                           color: Color(0xFF3D82AE),
//                                           border: Border.all(width: 1.0),
//                                           borderRadius: BorderRadius.circular(16)),
//                                       child: FittedBox(
//                                         child: Image.asset("assets/images/bag_1.png"),
//                                       ),
//                                     ),
//                                     flex: 1,
//                                   ),
//                                   Expanded(
//                                     child: Container(
//                                       //color: Colors.brown,
//                                       child: Column(
//                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                           Text("Name"),
//                                           Text("Color"),
//                                           Text("Price")
//                                         ],
//                                       ),
//                                     ),
//                                     flex: 2,
//                                   )
//                                 ],
//                               ),
//                               flex: 4,
//                             ),
//                             Expanded(
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Quantity()
//                                 ],
//                               ),
//                               flex: 1,
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(top: 20),
//                         width: 350,
//                         height: 150,
//                         color: Colors.green,
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(top: 20),
//                         width: 350,
//                         height: 150,
//                         color: Colors.brown,
//                       ),
//                     ],
//                   ),
