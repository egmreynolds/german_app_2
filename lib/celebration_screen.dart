import 'package:flutter/material.dart';
import 'package:german_app_2/home_screen.dart';
import 'package:german_app_2/question_data.dart';
import 'package:german_app_2/listen_screen_2.dart';

class CelebrationScreen extends StatefulWidget {
  QuestionData data;
  CelebrationScreen({required this.data});

  @override
  _CelebrationScreenState createState() => _CelebrationScreenState();
}

class _CelebrationScreenState extends State<CelebrationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final data = ModalRoute.of(context)!.settings.arguments as QuestionData;


    return Scaffold(
      appBar: AppBar(
        title: Text('Celebration'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.data.score == 1)
              Text(
                'Congratulations, you got 100%!',
                style: TextStyle(fontSize: 24),
              ),
            if (widget.data.attempts >= 3 && widget.data.score != 1)
              Text(
                'You scored ${widget.data.score * 100}% after 3 attempts, well done!',
                style: TextStyle(fontSize: 24),
              ),
            if (widget.data.attempts < 3 && widget.data.score != 1)
              Text(
                'You scored ${widget.data.score * 100}% after ${widget.data.attempts} attempts, Keep Going!',
                style: TextStyle(fontSize: 24),
              ),
            SizedBox(height: 30),
            if (widget.data.score == 1 || widget.data.attempts >= 3)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen()
                    ),
                  );
                },
                child: Text('Back to Home'),
              ),
            if (widget.data.score != 1 && widget.data.attempts < 3)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListenScreen2(data: widget.data)
                    ),
                  );
                },
                child: Text('Try Again'),
              ),
          ],
        ),
      ),
    );
  }
}