import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/cart_screen.dart';
import './providers/orders.dart';
import './providers/products.dart';
import './providers/cart.dart' as Cart;

//DONT USE PROVIDERS ON LOCAL STATE WIDGETS(STATE THAT ONLY WORK IN A WIDGET, LIKE SWITCHIN A BUTTON)
//DONT USE IT BECAUSE YOU KNOW WHEN YOU ISE IT WILL BE GLOBALLY INSTEAD USE STATEFULL WIDGETS

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

    //Here is the better approach for not using value, WHY? Because you will use that instance..
    //..for al the project, this is for efficenty, whenever you reuse an existing object use value

    //If you replace the page using provider, dont wonrry ChangeNotifierProvider cleans it up for you

    return MultiProvider(
      //Can listen by both providers everywhere
      providers: [
        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart.Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDefailScreen.routeName: (_) => ProductDefailScreen(),
          CardScreen.routeName: (_) => CardScreen(),
        },
      ),
    );
  }
}
