import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drarwer.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart' as Cart;
import '../screens/cart_screen.dart';
import '../providers/products.dart';

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
  bool _isInit = true;

  //Remember that this method only runs once
  @override
  void initState() {
    //WONT WORK, WE ARE USING CONTEXT HERE, THE WIDGET IS NOT READY, NOW IT WORKS IF YOU PUT LISTE: FALSE
    //OTHERWISE THIS WILL BE THE PERFECT SOLUTION
    // Provider.of<Products>(context).fetchAndSetProducts();

    //Other solution like putting the LISTEN:FALSE is this, cause Flutter order this diffent, it is a to do
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  //Another way, this runs after the widget is ready and before the build runs for the first time
  //But this runs a couple of times, so for that is the logic
  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Products>(context).fetchAndSetProducts();
      _isInit = false;
    }
    super.didChangeDependencies();
  }

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
          //It goes up and find the provider in the main class
          Consumer<Cart.Cart>(
            builder: (_, card, ch) => Badge(
              child: ch,
              value: card.itemCount.toString(),
            ),
            //This dont need to be rebuild
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CardScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      //I am taking the grid away cause i dont wanna rebuild the appBar of this widget
      //Im not using _showOnlyFavorities with the provider cause it will change the list everywhere
      //I am using locally so i transform this widget to statefull
      body: ProductsGrid(_showOnlyFavorities),
    );
  }
}
