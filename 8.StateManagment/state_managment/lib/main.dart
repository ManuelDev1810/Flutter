import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './providers/products.dart';

//I need to provide a class which you then wanna use from different widgets at the height..
//..possible point of all these widgets which will be interested
//This means that if ProductsOverviewScreen and ProductDefailScreen wants the data..
//I have to put the provider on a class above them, which is exactly this class..
//That does not mean that the build method will run again on this class, only the ones which are listenen

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Regesring this class with a provider so the child widgets that are LISTEBER will be rebuild..
    //..when the data changes
    return ChangeNotifierProvider(
      //Returning the Provider, all the listener will have only this instance.
      create: (ctx) => Products(),
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {ProductDefailScreen.routeName: (_) => ProductDefailScreen()},
      ),
    );
  }
}
