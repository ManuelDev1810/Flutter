import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    // return Container(
    //This fixed size in the height is a problem, when we put the mobile rotated, and you scroll down the list..
    //The list just take all the size, because it take 450 that height that i has right now
    //So 450 it fine when it is not landscape, but when it it landscape it is too hight and so....
    //... the parent of the list is a SingleChildScrollView, so you can scroll it down from the chart..
    //... and when you do it the list if its large will take all the space and you wont be able to go back
    // height: 450,

    //This methord return us the available height of the device so we are taking 60% percent of the devive height
    //The value goes from 0 to 1
    // height: MediaQuery.of(context).size.height * 0.6,

    //ListView its like a column with SingleChildScrollView
    //ListView has to have a size, for exmaple if its wrapper with a container and the container has a height
    //If we delete the container it will give us an error because it will look for the parent in UsrTransactions
    //And the parent is a column, a column take as much as it can, so the ListView will be infinite
    //ListView.builder is can of better, because does not render all., ListView does
    //ListView.builder only render whats visible
    return transactions.isEmpty
        //You have a problem with image in landscape mode, it has to height, now you have in the main..
        //That this widget will take only the 70% with mediaquery, so you can put a constrain here
        ? LayoutBuilder(builder: (ctx, constrains) {
            return Column(
              children: <Widget>[
                Text(
                  'Not images yet',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 20,
                ),
                //BoxFit.Cover will give us an error if we put it without the container because...
                //...Because the direc parent is the column and you know that has no limite
                Container(
                  height: constrains.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('\$${transactions[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => deleteTx(transactions[index].id),
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
