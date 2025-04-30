import 'package:just_audio/just_audio.dart';

class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> init() async {
    await _audioPlayer.setAsset('assets/audio/sample_audio.mp3');
  }

  void play() {
    print("playing from audio service");
    _audioPlayer.play();
  }

  void stop(){
    _audioPlayer.stop();
  }

  void dispose() {
    _audioPlayer.dispose();
  }

  AudioPlayer get audioPlayer => _audioPlayer;
}
