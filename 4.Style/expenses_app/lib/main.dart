import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {

  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shows',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );

    //Dart save objects in memory and only store pointer at these  objects
    //The pointer, the address itself is final, so cant do userTransaction = blablabla
    //But the values are not final, so we can manipulate the list cause that doesnt change the pointer

    setState(() {
      //This method add a new transaction but no change the address or the pointer
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
      return NewTransaction(_addNewTransaction);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      //SingleChildScrollView has to be in the body to know what size to take, the height to take.
      //If you have to put it in another part, you can put a container with a height and then put it
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //The card by default take the size of its child, so we need to change the size of the text
            //But Text take the size of its parent
            //So put the text in a container to put a width

            //Another way to it is put the card in a container with its wild, so the thing here
            //The thing is that card depends on the size of its child, unless
            //Unless the card itself it's grap in a contianer
            Container(
              width: double.infinity,
              child: Card(
                //Now the size of the card depends of the size of the container that we can control
                color: Colors.blue,
                child: Text('CHART!'),
                elevation: 5,
              ),
            ),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
