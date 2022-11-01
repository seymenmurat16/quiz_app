import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:quiz_app/constant.dart';

void main() => runApp(Quiz());

class Quiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.indigo[700],
            body: SafeArea(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: QuizPage(),
            ))));
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> choices = [];
  List<Question> questionBank = [
    Question(question: 'Titanic is the biggest ship ever', answer: false),
    Question(
        question:
            'The number of chickens in the world is more than the number of people',
        answer: true),
    Question(question: 'Butterflies have a lifespan of 1 year', answer: false),
    Question(question: 'The world is flat', answer: false),
    Question(
        question: 'Cashew nut is actually the stem of a fruit', answer: true),
    Question(
        question: 'Fatih Sultan Mehmet has never eaten potatoes', answer: true),
  ];
  int questionNo = 0;
  void buttonFunction(bool selection) {
    questionBank[questionNo].answer == selection
        ? choices.add(cCorrectIcon)
        : choices.add(cFalseIcon);
    questionNo = questionNo + 1;
    if (questionNo == questionBank.length) {
      questionNo = questionNo - 1;
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Congrats!!! You finished the test.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
                setState(() {
                  questionNo = 0;
                  choices = [];
                });
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionBank[questionNo].question,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Wrap(spacing: 3, runSpacing: 3, children: choices),
        Expanded(
          flex: 1,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              child: Row(children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.all(12),
                              backgroundColor: Colors.red,
                              textStyle: TextStyle(color: Colors.white)),
                          child: Icon(
                            Icons.thumb_down,
                            size: 30.0,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              buttonFunction(false);
                            });
                          },
                        ))),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.all(12),
                              backgroundColor: Colors.green[400],
                              textStyle: TextStyle(color: Colors.white)),
                          child: Icon(Icons.thumb_up,
                              size: 30.0, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              buttonFunction(true);
                            });
                          },
                        ))),
              ])),
        )
      ],
    );
  }
}

class Question {
  String question;
  bool answer;
  Question({required this.question, required this.answer});
}
