import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Registering this widget as a listener of the Products provider, and now this method goes ahead and go..
    //..to the parent class of this class the ProductsOverviewScreen and there it finds no provider..
    //..then goes ahead and go to the parent of the ProductsOverviewScreen, fins the Main class..
    //..with the Product Provider
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;

    return GridView.builder(
      padding: EdgeInsets.all(15),
      itemCount: products.length,
      //In the ProductItem Im fine passing data thorfgt the constructor because this is data that..
      //..the ProductItem needs, not data that it will go up again like a reference method etc
      itemBuilder: (ctc, index) => ChangeNotifierProvider(
        create: (_) => products[index], //Returning a provider for each Product
        //The good thing about this is that only that particular product will rebuild
        
        //This NESTLE PROVIDER will become a problem because on this cases when we use..
        //..builder(means that show only the neccesary), what flutter does is that reuses the widget..
        //..and only change the data, so we will a get a provider with a different product
        child: ProductItem(
          // products[index].id,
          // products[index].title,
          // products[index].imageUrl,
        ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //2 colums always
        childAspectRatio: 1.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
