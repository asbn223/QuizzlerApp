import 'package:flutter/material.dart';
import 'package:quizzler_app/questionsbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(MyApp());

QuestionBrain questionBrain = new QuestionBrain();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
//  List<String> questions = [
//    "Flutter is made by Google",
//    "Flutter uses Java Programming Langauge",
//    "The capital of Libya is Benghazi", //False
//    "Albert Einstein was awarded the Nobel Prize in Physics" //True
//  ];
//

//
//  List<bool> answer = [true, false, false, true];

  int score = 0;

  void checkAnswer(bool userAnswer) {
    setState(() {
      if (questionBrain.isFinished()) {
        Alert(
            title: "Congralutions",
            context: context,
            desc: "You have answered $score questions correctly!.",
            buttons: [
              DialogButton(
                child: Text(
                  "Ok",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              )
            ]).show();
        questionBrain.reset();
        score = 0;
        scoreKeeper.clear();
      } else {
        if (userAnswer == true) {
          score++;
          scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
              size: 24,
            ),
          );
        } else {
          scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
              size: 24,
            ),
          );
        }
        questionBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              color: Colors.green,
              child: Text(
                "True",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                "False",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: scoreKeeper,
          ),
        ),
      ],
    );
  }
}
