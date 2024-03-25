// ASK HOW THIS ONE SHOULD WORK!!!!!

import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';

import 'package:flutter/material.dart';
import 'dart:async';


class WaveAnimationPage extends StatefulWidget {
  const WaveAnimationPage({super.key, required this.title});

  final String title;

  @override
  _WaveAnimationPageState createState() => _WaveAnimationPageState();
}

class _WaveAnimationPageState extends State<WaveAnimationPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double maxAmplitude = 0.2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2))..repeat();
  }

  // // This whole block can be commented out if we don't want to use phone movement
  // static const Duration _ignoreDuration = Duration(milliseconds: 50);
  // UserAccelerometerEvent? _userAccelerometerEvent;
  // DateTime? _userAccelerometerUpdateTime;
  // // DateTime? _accelerometerUpdateTime;
  // // DateTime? _gyroscopeUpdateTime;
  // // DateTime? _magnetometerUpdateTime;
  // // ignore: unused_field
  // int? _userAccelerometerLastInterval;
  // final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  // Duration sensorInterval = SensorInterval.normalInterval;

  @override
  Widget build(BuildContext context) {
    // maxAmplitude = distance([_userAccelerometerEvent!.x, _userAccelerometerEvent!.y, _userAccelerometerEvent!.z]);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildWave(),
            const SizedBox(height: 80),
            _buildSlider(),
          ],
        ),
      ),
    );
  }

  Widget _buildWave() {
    return SizedBox(
      width: 300,
      height: 100,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: WavePainter(_controller.value, maxAmplitude),
          );
        },
      ),
    );
  }

  Widget _buildSlider() {
    return SizedBox(
      width: 300,
      child: Slider(
        value: maxAmplitude,
        min: 0.00,
        max: 0.75,
        onChanged: (newValue) {
          setState(() {
            maxAmplitude = newValue;
          });
        },
      ),
    );
  }

  double distance(List<double> numbers){
    double totalDistance = 0.0;
    for (int i = 0; i < numbers.length; i++){
      totalDistance = totalDistance + pow(numbers[i], 2);
    }
    totalDistance = sqrt(totalDistance);
    // print(totalDistance);
    double newDistance = totalDistance / 20;
    if (newDistance > 0.75){
      newDistance = 0.75;
    }

    return newDistance;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //new dispose and initState. Comment out and uncomment above ones to revert
  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  //   for (final subscription in _streamSubscriptions) {
  //     subscription.cancel();
  //   }
  // }

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this, duration: Duration(seconds: 2))..repeat();
//     _streamSubscriptions.add(
//       userAccelerometerEventStream(samplingPeriod: sensorInterval).listen(
//         (UserAccelerometerEvent event) {
//           final now = DateTime.now();
//           setState(() {
//             _userAccelerometerEvent = event;
//             if (_userAccelerometerUpdateTime != null) {
//               final interval = now.difference(_userAccelerometerUpdateTime!);
//               if (interval > _ignoreDuration) {
//                 _userAccelerometerLastInterval = interval.inMilliseconds;
//               }
//             }
//           });
//           _userAccelerometerUpdateTime = now;
//         },
//         onError: (e) {
//           showDialog(
//               context: context,
//               builder: (context) {
//                 return const AlertDialog(
//                   title: Text("Sensor Not Found"),
//                   content: Text(
//                       "It seems that your device doesn't support User Accelerometer Sensor"),
//                 );
//               });
//         },
//         cancelOnError: true,
//       ),
//     );
//   }
}



// Wave class. Doesn't have to do with accelerometer
class WavePainter extends CustomPainter {
  final double animationValue;
  final double maxAmplitude;

  WavePainter(this.animationValue, this.maxAmplitude);

  @override
  void paint(Canvas canvas, Size size) {
    final double amplitude = size.height * maxAmplitude; // Adjust this for wave height
    // final double wavelength = size.width / 2; // Adjust this for wave width
    final double frequency = 2 * pi / size.width;

    final Path path = Path();

    for (double x = 0; x <= size.width; x++) {
      final double y = amplitude * sin(frequency * x + animationValue * 2 * pi) + size.height / 2;
      if (x == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    final Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}