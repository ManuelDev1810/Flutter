import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart' as Cart;

class ProductItem extends StatelessWidget {

  //DONT USE PROVIDERS ON LOCAL STATE WIDGETS(STATE THAT ONLY WORK IN A WIDGET, LIKE SWITCHIN A BUTTON)
  @override
  Widget build(BuildContext context) {
    //How we create once product_provider for one product_item that's what we get, THIS IS NESTERPROVIDERS
    final product = Provider.of<Product>(context, listen: false);
    print('product rebuild');
    //Now this listener go up till find the provider in the main class
    final card = Provider.of<Cart.Cart>(context, listen: false);

    //Another way for listener is use Consume instead of provider..
    //This is useful when you only want to rebuild a part of your code, because with Provider..
    //..you rebuild everything, so you can put provder to listen false and use customer when you need changes

    //We cant put GridTile with border radius, so we use ClipRRect to transform the look of this widget
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        //In this case we use this widget only for the tap, Image does not have one
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDefailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          //Only this part will rebuild cause we have provider.listerner false and we are using consumer here
          //Consumer always has listener:true and so we rebuld the iconbutton whenever icon change
          //So we shirnk the re build

          //Another way of accomplish this is to separe this iconbutton in a separate widget
          leading: Consumer<Product>(
            builder: (ctx, product, child) => IconButton(
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              onPressed: () {
                product.toggleFavoriteStatus();
              },
              color: Theme.of(context).accentColor,
            ),
            // child: Text('Never rebuild, you can use like label:child in the builder, but this never changes'),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              card.addItem(product.id, product.price, product.title,);
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
