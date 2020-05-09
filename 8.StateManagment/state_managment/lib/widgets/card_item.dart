import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/card.dart'  as CardProvider show Card;

class CardItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CardItem(this.id, this.productId, this.price, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {
    print('Hey');
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context)
            .errorColor, // we dont have this defined but it is the default color RED\
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<CardProvider.Card>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text(
                    '\$$price',
                  ),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${(quantity * price)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
