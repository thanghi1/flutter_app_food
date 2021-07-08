import 'package:flutter_app_food/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Provider/Product.dart';
import 'categories.dart';
import 'models/Productx.dart';
import 'package:flutter_app_food/itemcard.dart';
import 'package:flutter_app_food/detail_screen.dart';
import 'test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());

}

// Future<Product> _getpdCart() async {
//     SharedPreferences _prefs = await SharedPreferences.getInstance();
//     final pdCart = _prefs.get("pdCartKey")?? null;
//
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage()
      ),
    );
  }
}

///////////////////////////////////////////////////////////



class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.grey,
          iconSize: 30,
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search_rounded),
            color: Colors.grey,
            iconSize: 30,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => test()));
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Colors.grey,
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
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: StreamBuilder<List<Product>>(
          stream: productProvider.products,
          builder: (context, snapshot) {

            if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.75),
                itemBuilder: (context, index) => ItemCard(
                  product: snapshot.data[index],
                  press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailProduct(
                          product: snapshot.data[index],
                        ),
                      )),
                ),
              ),
            );
          }
      ),
    );
  }

}
