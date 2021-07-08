import 'package:flutter/material.dart';
import 'models/Productx.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  final Function press;
  const ItemCard({
    Key key, this.product, this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(20),
              //height: 180,
              //width: 160,
              decoration: BoxDecoration(
                  color: Color(product.color),
                  borderRadius: BorderRadius.circular(16)),
              child: Hero(
                  tag: "${product.id}",
                  child: Image.asset(product.image,)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(product.title, style: TextStyle(color: Colors.grey),),
          ),
          Text('\$' + product.price.toString(), style: TextStyle(fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}