import 'package:flutter/material.dart';
import '../components/music_visualizer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<MusicVisualizerState> _visualizerKey = GlobalKey<MusicVisualizerState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Visualizer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MusicVisualizer(key: _visualizerKey),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                _visualizerKey.currentState?.play(); // Trigger play action
              },
              icon: Icon(Icons.play_arrow),
              label: Text('Play'),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                _visualizerKey.currentState?.stop(); // Trigger stop action
              },
              icon: Icon(Icons.stop),
              label: Text('Stop'),
            ),
          ],
        ),
      ),
    );
  }
}
