import 'package:flutter/material.dart';
//import 'package:german_app_2/additional_methods.dart';
import 'package:german_app_2/listen_screen_2.dart';
import 'package:german_app_2/question_data.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';
import 'package:tuple/tuple.dart';

// Screen 1 where the user selects a question
class ListenScreen1 extends StatefulWidget {
  @override
  _ListenScreen1State createState() => _ListenScreen1State();
}

class _ListenScreen1State extends State<ListenScreen1> {
  List<String> questions = [];
  List<int> question_ids = [];

  @override
  void initState() {
    super.initState();
    selectRandomQuestions(3).then((data) {
      setState(() {
        questions = data.item1 ?? []; //assign empty list if result is null
        question_ids = data.item2 ?? [];
      });
    });
  }

// Provided filepath, return list of strings from that text.
  Future<List<String>> extractQuestionsFromFile(String filePath) async {
    // Read the text file
    String fileContent = await rootBundle.loadString(filePath);
    // Split the file content into individual lines/questions
    List<String> lines = fileContent.split('\n');
    // Remove any empty lines or whitespace
    List<String> questions = lines.where((line) => line.trim().isNotEmpty).toList();
    return questions;
  }

  // get list of texts. Select random strings,
  Future<Tuple2<List<String>, List<int>>> selectRandomQuestions(int n) async {
    List<String> selectedQuestions = [];
    String filePath = "assets/a2_question.txt";
    List<String> questions = await extractQuestionsFromFile(filePath);
    //select n random questions
    List<int> indices = List<int>.generate(questions.length, (index) => index);
    indices.shuffle();
    indices = indices.take(3).toList();

    for (int index in indices) {
      selectedQuestions.add(questions[index]);
    }

    return Tuple2(selectedQuestions, indices);
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Listen Screen 1'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Listen Screen 1'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'What question would you like to ask?',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ListenScreen2(data: QuestionData(
                              question: questions[0],
                              attempts: 0,
                              score: 0,
                              id: question_ids[0]))
                  ),
                );
              },
              child: Text(questions[0]),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ListenScreen2(data: QuestionData(
                              question: questions[1],
                              attempts: 0,
                              score: 0,
                              id: question_ids[1]))
                  ),
                );
              },
              child: Text(questions[1]),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ListenScreen2(data: QuestionData(
                              question: questions[2],
                              attempts: 0,
                              score: 0,
                              id: question_ids[2]))
                  ),
                );
              },
              child: Text(questions[2]),
            ),
          ],
        ),
      );
    }
  }
}
