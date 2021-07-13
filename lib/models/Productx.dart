
import 'dart:convert';

class Product {
  final String id, image, title, description;
  final int price, size, color, total_quality;

  Product({
      this.id,
      this.image,
      this.title,
      this.price,
      this.description,
      this.size,
      this.color,
      this.total_quality
  });


  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
      color: json['color'],
      size: json['size'],
      total_quality: json['total_quality']
    );
  }

  Map<String,dynamic> toMap(){
    return{
      'id' : id,
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'color': color,
      'size': size,
      'total_quality' : total_quality
    };
  }

  Map<String,dynamic> FromInstanceToJsonString(Product product){
    return <String, dynamic>
    {
      'id' : product.id,
      'title': product.title,
      'description': product.description,
      'price': product.price,
      'image': product.image,
      'color': product.color,
      'size': product.size,
      'total_quality': product.total_quality
    };
  }


}
class PhotosList {
  final List<Product> photos;

  PhotosList({
    this.photos,
  });
  factory PhotosList.fromJson(List<dynamic> parsedJson) {

    var photos = List<Product>.empty();
    photos = parsedJson.map((e) => Product.fromJson(jsonDecode(e))).toList();
    return PhotosList(
      photos: photos,
    );
  }
}




