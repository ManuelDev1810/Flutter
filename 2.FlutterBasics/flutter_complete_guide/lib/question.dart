import 'package:flutter/material.dart';

class Question extends StatelessWidget {

  //If you put const before of a variable, the variable and the values will be const
  //If you put const after the variable only the values will be const, that menast that you can do this va=[]
  //Final is run time
  //A final propertie can be initialized, after that it never changes
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(
        questionText,
        style: TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }
}
