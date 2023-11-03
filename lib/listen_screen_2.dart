import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:german_app_2/listen_screen_3.dart';
import 'dart:async';
import 'package:german_app_2/question_data.dart';
import 'package:flutter/services.dart' show rootBundle;

// Screen 2 where the selected question is played as audio
class ListenScreen2 extends StatefulWidget {
  QuestionData data;
  ListenScreen2({required this.data});

  @override
  _ListenScreen2State createState() => _ListenScreen2State();
}

class _ListenScreen2State extends State<ListenScreen2> {
  AudioPlayer _audioPlayer = AudioPlayer();
  String currentQuestion = "";
  double playbackSpeed = 1.0;
  bool _isPlaying = false;
  bool _isLoading = false;
  double _position = 0.0;
  double _duration = 0.0;
  String textContent = "";
  double textScaleFactor = 1.0;

  @override
  void initState() {
    super.initState();
    playbackSpeed = widget.data.calculatePlaybackSpeed();

    _audioPlayer.setPlaybackRate(playbackSpeed);
    // Set up listeners for audio position and duration changes
    _audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        _position = position.inSeconds.toDouble();
      });
    });

    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        _duration = duration.inSeconds.toDouble();
      });
    });

    if (widget.data.attempts >= 2) {
      _loadTextContent();
    }
  }

  Future<void> _loadTextContent() async {
    final text = await rootBundle.loadString('assets/answers/answers_${widget.data.id + 1}.txt');
    setState(() {
      textContent = text;
    });
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  // Play the audio file
  Future<void> _playAudio() async {
    if (!_isLoading && !_isPlaying) {
      setState(() {
        _isLoading = true;
      });
      await _audioPlayer.play(AssetSource("audio/audio_${widget.data.id + 1}.mp3"));
      setState(() {
        _isPlaying = true;
        _isLoading = false;
      });
    }
  }

  // Pause the audio file
  Future<void> _pauseAudio() async {
    if (!_isLoading && _isPlaying) {
      setState(() {
        _isLoading = true;
      });
      await _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
        _isLoading = false;
      });
    }
  }

  // Seek to a specific position in the audio file
  Future<void> _seekAudio(double value) async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      await _audioPlayer.seek(Duration(seconds: value.toInt()));
      setState(() {
        _position = value;
        _isLoading = false;
      });
    }
  }

  // Set the playback speed of the audio file
  Future<void> _setPlaybackRate(double value) async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      await _audioPlayer.setPlaybackRate(value);
      setState(() {
        playbackSpeed = value;
        _isLoading = false;
      });
    }
  }

  void _handleDoubleTap() {
    setState(() {
      if (textScaleFactor == 1.0) {
        textScaleFactor = 1.5; //zoom in
      } else {
        textScaleFactor = 1.0; //zoom out
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //final data = ModalRoute.of(context)!.settings.arguments as QuestionData;
    currentQuestion = widget.data.question;

    return Scaffold(
      appBar: AppBar(
        title: Text('Listen Screen 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Question: $currentQuestion',
              style: TextStyle(fontSize: 20),
            ),
            if (widget.data.attempts >= 2)
              GestureDetector(
                onDoubleTap: _handleDoubleTap,
                child: Text(textContent, textScaleFactor: textScaleFactor,),
              ),
            const SizedBox(height: 20),

            IconButton(
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              iconSize: 64,
              onPressed: _isPlaying ? _pauseAudio : _playAudio,
            ),
            Slider(
              value: _position,
              min: 0.0,
              max: _duration,
              onChanged: _seekAudio,
            ),
            Text(
              '${_position.toInt()} sec / ${_duration.toInt()} sec',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                dispose();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListenScreen3(data: widget.data)
                  ),
                );

              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}