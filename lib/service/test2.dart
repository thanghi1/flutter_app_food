
import 'package:flutter/material.dart';
import 'package:flutter_app_food/Provider/Product.dart';
import 'package:flutter_app_food/itemcard.dart';
import 'package:flutter_app_food/models/Productx.dart';
import 'package:provider/provider.dart';

class ScreenTest2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      body: StreamBuilder<List<Product>>(
        stream: productProvider.products,
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.builder(
                      itemCount: snapshot.data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 20,
                          childAspectRatio: 0.75),
                      itemBuilder: null
                    ),
                  ))
            ],
          );
        }
      ),
    );
  }
}


