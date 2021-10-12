import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;
  bool inCart = false;

  CartItem(this.id, this.title, this.price, this.quantity);
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get allItems {
    return {..._items};
  }

  int itemsCount() {
    return _items.length;
  }

  double totalPrice() {
    var total = 0.0;
    _items.forEach((key, CartItem) {
      total += CartItem.price * CartItem.quantity;
    });
    return total;
  }

  void increaseQuantity(String productId) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existedItem) => CartItem(existedItem.id, existedItem.title,
              existedItem.price, existedItem.quantity + 1));
    }
    notifyListeners();
  }

  void decreaseQuantity(String productId) {
    if (_items.containsKey(productId)) {
      CartItem c =
          _items.values.firstWhere((element) => element.id == productId);
      if (c.quantity >= 1) {
        _items.update(
            productId,
            (existedItem) => CartItem(existedItem.id, existedItem.title,
                existedItem.price, existedItem.quantity - 1));
      }
    }
    notifyListeners();
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existedItem) => CartItem(existedItem.id, existedItem.title,
              existedItem.price, existedItem.quantity));
    } else {
      // add new item
      _items.putIfAbsent(productId, () => CartItem(productId, title, price, 1));
    }
    notifyListeners();
  }

  void removeItem(String itemKey) {
    _items.remove(itemKey);
    print("Item key :" + itemKey);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId,
          (existedItem) => CartItem(existedItem.id, existedItem.title,
              existedItem.price, existedItem.quantity - 1));
    } else {
      _items.remove(productId);
      notifyListeners();
    }
  }

  void clear() {
    _items = {};
  }
}
