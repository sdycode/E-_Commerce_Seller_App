import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imgUrl;
  final String backImgUrl;
  bool isFaviourate;
  bool isAddedInCart;

  Product( 
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imgUrl,
      required this.backImgUrl,
      this.isFaviourate = false,
      this.isAddedInCart = false});

  void changeFavouriteStatus() {
    isFaviourate = !isFaviourate;
    notifyListeners();
  }

  void changeCartStatus() {
    isAddedInCart = !isAddedInCart;
    notifyListeners();
  }
}
