import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String language = 'German';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              language,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/listen_screen_1.dart');
              },
              child: Text('Listen'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/speak_screen');
              },
              child: Text('Speak'),
            ),
          ],
        ),
      ),
    );
  }
}