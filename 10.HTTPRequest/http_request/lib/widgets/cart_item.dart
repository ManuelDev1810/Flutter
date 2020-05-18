import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' as CartProvider show Cart;

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem(this.id, this.productId, this.price, this.quantity, this.title);

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
      confirmDismiss: (direction) {
        //For Diaglog we dont have to use Scaffold, cause Dialog is not attached to the page..
        //..it can be shows anywhere... it returns a Future
        return showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Are you sure?'),
                  content:
                      Text('Do you want to remove the item from the cart?'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('No'),
                      onPressed: () {
                        Navigator.of(ctx).pop(false);//Read the showDialog
                      },
                    ),
                    FlatButton(
                      child: Text('Yes'),
                      onPressed: () {
                        Navigator.of(ctx).pop(true);//Read the showDialog
                      },
                    ),
                  ],
                ));
      },
      onDismissed: (direction) {
        Provider.of<CartProvider.Cart>(context, listen: false)
            .removeItem(productId);
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
