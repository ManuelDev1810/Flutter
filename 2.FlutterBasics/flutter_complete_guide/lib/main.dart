import 'package:flutter/material.dart';
import './answer.dart';
import './quiz.dart';
import './result.dart';

void main() {
  //Dart instantiate the class putting ()
  runApp(MyApp());
}

//This will not be persistence, here all is going to be rebuild, it wil be recreated
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

//INFO: _ make the class private
//This will be persistence, our data will not be reset cause it is statefull
class _MyAppState extends State<MyApp> {
  final _questions = const [
    //This is a Map, is an array but like with key, values
    {
      'questionText': 'What\'s your favorite color?',
      'answer': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 3},
        {'text': 'White', 'score': 1}
      ]
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answer': [
        {'text': 'Rabbit', 'score': 1},
        {'text': 'Snake', 'score': 11},
        {'text': 'Elephant', 'score': 5},
        {'text': 'Lios', 'score': 9}
      ]
    },
    {
      'questionText': 'What\'s your favorite instructor?',
      'answer': [
        {'text': 'Max', 'score': 10},
        {'text': 'Max', 'score': 10},
        {'text': 'Max', 'score': 10},
        {'text': 'Max', 'score': 10}
      ]
    }
  ];
  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    //WARNING: setState will rebuild the build method, all inside will be recreated
    //INFO: Flutter is smart enoguht to notice what changed and that what changed will be redraw

    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
  }

  //Flutter calls the build method
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Scaffold create the commun structure for a mobile app
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
              )
            : Result(_totalScore, _resetQuiz)
      ),
    );
  }
}
