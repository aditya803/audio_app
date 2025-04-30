// import 'package:audio_app/utils/constants.dart';
// import 'package:audio_waveforms/audio_waveforms.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';
//
// class WaveformsDashboard extends StatefulWidget {
//   const WaveformsDashboard({super.key});
//
//   @override
//   State<WaveformsDashboard> createState() => _WaveformsDashboardState();
// }
//
// class _WaveformsDashboardState extends State<WaveformsDashboard> {
//   late Duration maxDuration;
//   late Duration elapsedDuration;
//   late AudioCache audioPlayer;
//   late List<double> samples;
//   double sliderValue = 0;
//
//   WaveformType waveformType = WaveformType.fitWidth;
//   Future<void> parseData() async {
//
//     final samplesData = await compute(sampleAudioPath as ComputeCallback);
//
//     setState(() {
//       samples = samplesData["samples"];
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
