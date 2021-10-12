// ignore_for_file: prefer_final_fields
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
        id: "m1",
        title: "Parle",
        description: "Delicious biscuit",
        price: 10,
        imgUrl:
            'https://www.jiomart.com/images/product/150x150/490008739/parle-g-original-glucose-biscuits-800-g-0-20210115.jpg',
        backImgUrl:
            "https://m.media-amazon.com/images/I/81ijbz5abOL._SX569_.jpg"),
    Product(
        id: "m2",
        title: "Sugar",
        description: "Delicious biscuit",
        price: 10,
        imgUrl:
            'https://www.jiomart.com/images/product/150x150/491551493/loose-sugar-m-1-kg-0-20210304.jpg',
        backImgUrl:
            "https://vegprime.in/wp-content/uploads/2021/06/madhur-pure-hygienic-sugar-1-kg-1-20201112-300x300.jpg"),
    Product(
        id: "m3",
        title: "Maggie",
        description: "Delicious biscuit",
        price: 10,
        imgUrl:
            'https://www.jiomart.com/images/product/150x150/490003834/maggi-2-minute-masala-instant-noodles-560-g-0-20210811.jpg',
        backImgUrl:
            "https://www.zelorra.com/grocery/wp-content/uploads/2020/09/Maggi-Noodles-Masala-560g-Back.jpg")
  ];
  List<Product> get allItems {
    return [..._items];
  }

  List<Product> get favouriteItems {
    return _items.where((element) => element.isFaviourate).toList();
  }

  List<Product> get itemsInCart {
    return _items.where((element) => element.isAddedInCart).toList();
  }

  Product findProductById(String ID) {
    return _items.firstWhere((p) => p.id == ID);
  }

  Future<void> fetchAndSetProducts() async {
    const url =
        "https://shop-app-3868d-default-rtdb.firebaseio.com/products.json";
    Uri uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      print("Fetch response is : " + response.toString());
    } catch (error) {}
  }

  Future<void> addProduct(Product product) async {
    const url =
        "https://shop-app-3868d-default-rtdb.firebaseio.com/products.json";
    Uri uri = Uri.parse(url);
    try {
      final response = await http.post(uri,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imgUrl,
            'price': product.price,
            'isFavourite': product.isFaviourate
          }));

      var backendId = json.decode(response.body);
      print("BackEnd Id :" + backendId['name']);
      final newProduct = Product(
          title: product.title,
          backImgUrl: product.backImgUrl,
          description: product.description,
          id: backendId['name'],
          imgUrl: product.imgUrl,
          price: product.price);
      _items.add(newProduct);
      // b= backendId.toString();
      // print("Back end id is :" + backendId);
      notifyListeners();
    } catch (error) {
      print("Error in addition " + error.toString());
      throw error;
    }

    notifyListeners();
    // print("Before addition ites  : " + _items.length.toString());
    // print("Items : " + _items.length.toString());

    // print("After addition Items : " + _items.length.toString());
  }

  Future<void> updateProduct(String id, Product product) async {
    print("In update of edit screen in update function ????");
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      print("Index in http :  " + prodIndex.toString());
      const url =
          "https://shop-app-3868d-default-rtdb.firebaseio.com/products.json";
      Uri uri = Uri.parse(url);
      try {
        final response = await http.post(uri,
            body: json.encode({
              'title': product.title,
              'description': product.description,
              'imageUrl': product.imgUrl,
              'price': product.price,
              'isFavourite': product.isFaviourate
            }));

        var backendId = json.decode(response.body);
        print("BackEnd Id :" + backendId['name']);
        final newProduct = Product(
            title: product.title,
            backImgUrl: product.backImgUrl,
            description: product.description,
            id: backendId['name'],
            imgUrl: product.imgUrl,
            price: product.price);
        //_items.add(newProduct);
        _items[prodIndex] = newProduct;
        // b= backendId.toString();
        // print("Back end id is :" + backendId);
        notifyListeners();
      } catch (error) {
        print("Error in " + error.toString());
        throw error;
      }
    } else {
      return Future.value();
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
