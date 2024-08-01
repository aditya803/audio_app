import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/services.dart';
import '../utils/constants.dart';

class MusicVisualizer extends StatefulWidget {
  MusicVisualizer({Key? key}) : super(key: key);

  @override
  MusicVisualizerState createState() => MusicVisualizerState();
}

class MusicVisualizerState extends State<MusicVisualizer> {
  File? file;
  late final PlayerController _controller;
  late StreamSubscription<PlayerState> playerStateSubscription;

  @override
  void initState() {
    super.initState();
    _controller = PlayerController();
    playerStateSubscription = _controller.onPlayerStateChanged.listen((_) {
      setState(() {});
    });
    preparePlayer();
  }

  void preparePlayer() async {
    file = File('assets/audio/sample_audio.mp3');
    await file?.writeAsBytes(
        (await rootBundle.load('assets/audio/sample_audio.mp3')).buffer.asUint8List());
    _controller.extractWaveformData(path: sampleAudioPath).then((waveformData) => debugPrint(waveformData.toString()));
  }

  void play() async {
    await _controller.startPlayer();
  }

  void stop() async {
    await _controller.stopPlayer();
  }

  @override
  void dispose() {
    playerStateSubscription.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: AudioFileWaveforms(
        size: Size(MediaQuery.of(context).size.width, 200.0),
        playerController: _controller,
        playerWaveStyle: const PlayerWaveStyle(
          fixedWaveColor: Colors.purple,
          liveWaveColor: Colors.purpleAccent,
          spacing: 6,
        ),
        waveformType: WaveformType.fitWidth,
      ),
    );
  }
}
