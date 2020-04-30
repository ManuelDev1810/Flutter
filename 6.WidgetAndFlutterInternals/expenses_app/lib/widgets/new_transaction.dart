
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/adaptive_flat_button.dart';

//Right now when you put data into a text field and the to other, the data get lose
//To get this worked you have to convert this class into a statufull widget
//It will be basically maintained and not rebuily as ofen easily


//------------------------------------------------------------------------------------

//initState is a method inside the stateObject which will be called automatically when..
//..the state object is created for the first time
//Remember that state is an object separeted of the widget so when widget is rebuild, initState wont run again

//when you execute setState() or when the widget is rebuild because its parent build method was called..
//..then didUpdateWidget executes, and so this is another method that you can use in the stateOjbect
//And then again build runs
//If a widget is destroyed or removed because you rendered it condictionally then the dispose method is called

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx) {
    print('Constructor NewTransaction Widget');
  }

  @override
  _NewTransactionState createState()  {
    print('createStated NewTransaction Widget');
    return _NewTransactionState();
  } 
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  _NewTransactionState(){
    print('Constructor NewTransaction State');
  }

  @override
  void initState() {
    //Here you can some request etc
    print('initState()');
    //After initState, this is going to be called from the main, so the NewTransactionWidget will be called again
    //But this is going to be called only once it wont called the other method because is managed separetly
    super.initState();
  }

  //When the widget that is attachaed to the widget changed 
  //This method is called again because of the duplication after the initState()
  //You can use if you know something chanded in your parent widget and you need to received a new data
  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    print('didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('Dispose');
    super.dispose();
  }

  void _submitData() {
    if (_amountController.text.isEmpty) return null;
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    //With widget property you can use the things in your statufull class
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    //It close the modal
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            //Bottom is where our keyboard appear, viewInsets give us information about anything..
            //that is lapping into view and typically thats the soft keyboard
            //Then we have the bottom property that tell us how space is occupied by the keyboard
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                //I have a parameter that i dont care, i dont wanna use it
                //We pass a reference to the anonumous function, whwn i click there i wanna execute my funcion
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                //I have a parameter that i dont care, i dont wanna use it
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    AdaptiveFlatButton('Choose Date', _presentDatePicker),
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Add Transaction'),
                color: Colors.purple,
                textColor: Theme.of(context).textTheme.button.color,
                //Just passing the reference, not executing
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
