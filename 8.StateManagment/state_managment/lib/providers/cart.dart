import 'package:flutter/foundation.dart';

class CartItem {
  final String id; //this will be the id of the product not of the card item
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}


class Card with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cardItem) {
      total += (cardItem.price * cardItem.quantity);
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCardItem) => CartItem(
                id: existingCardItem.id,
                title: existingCardItem.title,
                price: existingCardItem.price,
                quantity: existingCardItem.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId){
    _items.remove(productId);
    notifyListeners();
  }

  void clear(){
    _items = {};
    notifyListeners();
  }
}
