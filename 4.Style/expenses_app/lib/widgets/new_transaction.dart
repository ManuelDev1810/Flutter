import 'package:flutter/material.dart';

//Right now when you put data into a text field and the to other, the data get lose
//To get this worked you have to convert this class into a statufull widget
//It will be basically maintained and not rebuily as ofen easily


class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if(enteredTitle.isEmpty || enteredAmount <= 0){
      return;
    }

    //With widget property you can use the things in your statufull class
    widget.addTx(
      titleController.text,
      double.parse(amountController.text),
    );

    //It close the modal
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              //I have a parameter that i dont care, i dont wanna use it
              //We pass a reference to the anonumous function, whwn i click there i wanna execute my funcion
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              //I have a parameter that i dont care, i dont wanna use it
              onSubmitted: (_) => submitData(),
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.purple,
              //Just passing the reference, not executing
              onPressed: submitData,
            ),
          ],
        ),
      ),
    );
  }
}
