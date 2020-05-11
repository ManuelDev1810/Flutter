import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditProductScreen createState() => _EditProductScreen();
}

class _EditProductScreen extends State<EditProductScreen> {
  //FocusNode save the focusNode of an input
  final _priceFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                //This controls what the bottom right button in the soft keyboard will show..
                //..whether is a checkmark or a done text or next input
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
              ),
                TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
