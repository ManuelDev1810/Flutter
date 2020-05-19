import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drarwer.dart';
import '../widgets/user_product_item.dart';
import '../providers/products.dart';
import './edit_product_screen.dart';

class UserProductsSreen extends StatelessWidget {
  static const routeName = '/user-products';

  //Async always return a Future
  Future<void> _refreshProducts(BuildContext context) async{
    //The future will resolve when the await finished
    await Provider.of<Products>(context).fetchAndSetProducts(); 
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productsData.items.length,
            //Dont have to put a height cause it is inside a ListView
            itemBuilder: (_, index) => Column(
              children: <Widget>[
                UserProductItem(
                  productsData.items[index].id,
                  productsData.items[index].title,
                  productsData.items[index].imageUrl,
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
