import 'package:flutter/foundation.dart';
import '../widgets/card_item.dart';

class CardItem {
  final String id; //this will be the id of the product not of the card item
  final String title;
  final int quantity;
  final double price;

  CardItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}


class Card with ChangeNotifier {
  Map<String, CardItem> _items = {};

  Map<String, CardItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((keu, cardItem) {
      total += (cardItem.price * cardItem.price);
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCardItem) => CardItem(
                id: existingCardItem.id,
                title: existingCardItem.title,
                price: existingCardItem.price,
                quantity: existingCardItem.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(
        productId,
        () => CardItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }
}
