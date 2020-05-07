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

      //This NESTLE PROVIDER will become a problem because on this cases when we use..
      //..builder(means that show only the neccesary), what flutter does is that reuses the widget..
      //..and only change the data, so we will a get a provider with a different product

      //This is another approach with value, is shorter cause we dont need the context
      //Now this is the right approach if you for example use a provider on something..
      //..thats part of a list of a grid, becayse what i put in nester provider, the problem with the builder..
      //..that just recycle the widget and use the data..
      //..WHEN USING .value you make sure that the provider works even if data changes for the widget.
      //..So if you have a builder function that would not work correctly, now it does

      //Whenever you reuse an existing object use value

      itemBuilder: (ctc, index) => ChangeNotifierProvider.value(
        value: products[index], //Returning a provider for each Product
        //The good thing about this is that only that particular product will rebuild
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
