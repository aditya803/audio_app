import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class MusicVisualizer extends StatefulWidget {
  MusicVisualizer({Key? key}) : super(key: key);

  @override
  MusicVisualizerState createState() => MusicVisualizerState();
}

class MusicVisualizerState extends State<MusicVisualizer> {
  late final PlayerController _controller;
  late StreamSubscription<PlayerState> playerStateSubscription;
  File? tempFile;  // Ensure this is a class-level variable

  @override
  void initState() {
    super.initState();
    _controller = PlayerController();
    preparePlayer();
    playerStateSubscription = _controller.onPlayerStateChanged.listen((_) {
      setState(() {});
    });
  }

  Future<void> preparePlayer() async {
    final byteData = await rootBundle.load('assets/audio/sample_audio.mp3');
    tempFile = File('${(await getTemporaryDirectory()).path}/sample_audio.mp3');
    await tempFile!.writeAsBytes(byteData.buffer.asUint8List(), flush: true);
    await _controller.extractWaveformData(path: tempFile!.path);
    print('Player prepared with file at ${tempFile!.path}');

  }

  Future<void> play() async {
    if (tempFile != null) {
      print('Starting player with path: ${tempFile!.path}');
      _controller.setVolume(10.0);
      await _controller.startPlayer();
    } else {
      print('Temp file is null.');
    }
  }

  Future<void> stop() async {
    print("stopping");
    //await _controller.stopPlayer();
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
        enableSeekGesture: true,
        playerController: _controller,
        playerWaveStyle: const PlayerWaveStyle(
          fixedWaveColor: Colors.black,
          liveWaveColor: Colors.purpleAccent,
          spacing: 6,
        ),
        waveformType: WaveformType.fitWidth,
      ),
    );
  }
}
