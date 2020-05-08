import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/card.dart' as Card;

enum FilterOptions {
  Favorities,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavorities = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyShop',
        ),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorities) {
                  _showOnlyFavorities = true;
                } else {
                  _showOnlyFavorities = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorities,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Card.Card>(
            builder: (_, card, ch) => Badge(
              child: ch,
              value: card.itemCount.toString(),
            ),
            //This dont need to be rebuild
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      //I am taking the grid away cause i dont wanna rebuild the appBar of this widget
      //Im not using _showOnlyFavorities with the provider cause it will change the list everywhere
      //I am using locally so i transform this widget to statefull
      body: ProductsGrid(_showOnlyFavorities),
    );
  }
}
