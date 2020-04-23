import './widgets/user_transactions.dart';
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

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
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
          UserTransactions(),
        ],
      ),
    );
  }
}
