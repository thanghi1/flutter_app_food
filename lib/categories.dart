import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<String> categories = ["Category1","Category2","Category3","Category4"];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) =>
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        categories[index],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: selectedIndex == index ? Colors.black : Colors.grey),),
                      Container(
                        margin: EdgeInsets.only(top: 6),
                        width: 30,
                        height: 3,
                        color: selectedIndex==index ? Colors.black : Colors.transparent,
                      )
                    ],
                  ),
                ),
              )),
    );
  }
}