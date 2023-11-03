import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:german_app_2/celebration_screen.dart';
import 'package:tuple/tuple.dart';
import 'package:german_app_2/question_data.dart';

// Screen 3 where the user selects correct statements related to the question
class ListenScreen3 extends StatefulWidget {
  QuestionData data;
  ListenScreen3({required this.data});

  @override
  _ListenScreen3State createState() => _ListenScreen3State();
}

class _ListenScreen3State extends State<ListenScreen3> {
  //List<String> possibleQuestions = [];
  //List<String> selectedQuestions = [];
  String currentQuestion = "";
  List<bool> _checkboxValues = [];
  List<bool> correctValues = [];
  List<String>? statements = [];
  @override
  void initState() {
    super.initState();
    loadStatements().then((data) {
      setState(() {
        statements = data.item1 ?? []; //assign empty list if result is null
        correctValues = data.item2 ?? [];
        });
      });
    }


    Future<Tuple2<List<String>?, List<bool>?>> loadStatements() async {
      int numberOfStatements = 5;

      String fileData = await rootBundle.loadString('assets/statements/statements_${widget.data.id + 1}.txt');
      List<String> statements = [];
      List<bool> correctValues = [];
      List<String> selectedStatements = [];
      List<bool> selectedCorrectValues = [];

      List<String> lines = fileData.split('\n');
      for (String line in lines) {
        List<String> parts = line.split('|');
        statements.add(parts[0]);
        correctValues.add(parts[1].trim().toLowerCase() == 'true');
      }
      // Get random 5.
      List<int> indices = List<int>.generate(numberOfStatements + 1, (index) => index);
      indices.shuffle();
      indices = indices.take(numberOfStatements).toList();

      for (int index in indices) {
        selectedStatements.add(statements[index]);
        selectedCorrectValues.add(correctValues[index]);
      }
      return Tuple2(selectedStatements, selectedCorrectValues);
    }

  double calculateScore() {
    int matchingCount = 0;
    for (int i = 0; i < _checkboxValues.length; i++) {
      if (_checkboxValues[i] == correctValues[i]) {
        matchingCount++;
      }
    }
    return matchingCount / _checkboxValues.length;
  }


  @override
  Widget build(BuildContext context) {
    //final data = ModalRoute.of(context)!.settings.arguments as QuestionData;
    currentQuestion = widget.data.question;

    return Scaffold(
      appBar: AppBar(
        title: Text('Listen Screen 3'),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Which Statements are Correct?',
              style: TextStyle(fontSize: 20),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: statements?.length,
              itemBuilder: (context, index) {
                if (_checkboxValues.length < statements!.length) {
                  _checkboxValues.add(false);
                }
                return CheckboxListTile(
                  title: Text(statements![index]),
                  value: _checkboxValues[index],
                  onChanged: (value) {
                    // Update the checkbox value
                    setState(() {
                      _checkboxValues[index] = value ?? false;
                    });
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              widget.data.score = calculateScore();
              widget.data.attempts += 1;
              // check scores and work out where to go next
              // Proceed to the next screen
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CelebrationScreen(data: widget.data)
                ),
              );
            },
            child: Text('Check Answers'),
          ),
        ],
      ),
    );

  }
}

