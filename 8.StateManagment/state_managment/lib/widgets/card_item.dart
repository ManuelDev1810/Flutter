import 'package:flutter/foundation.dart';

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
