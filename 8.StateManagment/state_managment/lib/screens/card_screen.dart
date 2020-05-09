import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/card_item.dart';
import '../providers/card.dart' as CardProvider;

class CardScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    //Im fine with rebuilding all this
    final card = Provider.of<CardProvider.Card>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Card'),
      ),
      //You can wrap all this into another widget if you want cause we dont the appbard to rebuild
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  //Put all the element to the right close to each other
                  Spacer(),
                  //This is an element with rounded cornes that you can use to show information
                  Chip(
                    label: Text(
                      '\$${card.totalAmount.toStringAsFixed(2)}',
                      //The default color of the primary text title
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.title.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text('ORDER NOW'),
                    onPressed: () {},
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: card.itemCount,
              itemBuilder: (_, index) => CardItem(
                card.items.values.toList()[index].id,
                card.items.keys.toList()[index],
                card.items.values.toList()[index].price,
                card.items.values.toList()[index].quantity,
                card.items.values.toList()[index].title,
              ),
            ),
          )
        ],
      ),
    );
  }
}
