import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drarwer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  // var _isLoading = false;

  // //Here ill use initState with the trick we mention in products
  // @override
  // void initState() {
  //   // Future.delayed(Duration.zero).then((_) {});
  //   //This will run before build runs
  //   // _isLoading = true;
  //   // Provider.of<Orders>(context, listen: false).fetchAndSetOrders().then((_) {
  //   //   setState(() {
  //   //     _isLoading = false;
  //   //   });
  //   // });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    print('building orders');
    //Gotta get this put cause we will get in a infinitive loop, because when this is done
    //Because when gettingAndSetting the orders is done it will call notifyListener so build..
    //..method will run again and gettingAndSetting will run again into an infinitive loop
    //Solucion is put orderData in a consumer when we need to use it and thats it
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Ordes'),
        ),
        drawer: AppDrawer(),
        //FutureBuilder, start listening to the future variable so add the then and catch methods for ya
        //
        body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (dataSnapshot.error != null) {
              return Center(child: Text('An Error occurred'));
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
                ),
              );
            }
          },
        ));
  }
}
