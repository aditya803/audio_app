import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => TestState();
}

class TestState extends State<Test> {
  late final AudioPlayer _audioPlayer;
  List<int> _waveform = [];
  File? _tempFile;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    preparePlayer();
    _audioPlayer.positionStream.listen((position) {
      setState(() {
        _position = position;
      });
    });
  }

  Future<void> preparePlayer() async {
    final byteData = await rootBundle.load('assets/audio/sample_audio.mp3');
    _tempFile = File('${(await getTemporaryDirectory()).path}/sample_audio.mp3');
    await _tempFile!.writeAsBytes(byteData.buffer.asUint8List(), flush: true);

    final audioFile = _tempFile!.path;
    await _audioPlayer.setFilePath(audioFile);
    _duration = (await _audioPlayer.load())!;

    // Simulate waveform data (you should replace this with real waveform extraction logic)
    _waveform = List<int>.generate(100, (index) => Random().nextInt(255));

    setState(() {});
  }

  Future<void> play() async {
    if (_tempFile != null && !_isPlaying) {
      await _audioPlayer.play();
      setState(() {
        _isPlaying = true;
      });
    } else {
      await _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });
    }
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
      _position = Duration.zero;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width, 200.0),
      painter: WaveformPainter(waveform: _waveform, position: _position, duration: _duration),
    );
  }
}

class WaveformPainter extends CustomPainter {
  final List<int> waveform;
  final Duration position;
  final Duration duration;

  WaveformPainter({required this.waveform, required this.position, required this.duration});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2.0;

    for (int i = 0; i < waveform.length; i++) {
      final x = i * (size.width / waveform.length);
      final y = size.height - (waveform[i] / 255.0 * size.height);
      canvas.drawLine(Offset(x, size.height), Offset(x, y), paint);
    }

    final progressPaint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 4.0;

    final progressX = (position.inMilliseconds / duration.inMilliseconds) * size.width;
    canvas.drawLine(Offset(progressX, 0), Offset(progressX, size.height), progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Always repaint when called
  }
}
