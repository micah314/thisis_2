import 'dart:math';
// import 'package:sensors_plus/sensors_plus.dart';

import 'package:flutter/material.dart';


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

  // UserAccelerometerEvent? _userAccelerometerEvent;

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
        min: 0.01,
        max: 0.75,
        onChanged: (newValue) {
          setState(() {
            maxAmplitude = newValue;
          });
        },
      ),
    );
  }

  // Widget _phoneMovement(){
  //   return Container(
  //     width: 300,
  //     onChanged
  //     distance([_userAccelerometerEvent!.x, _userAccelerometerEvent!.y, _userAccelerometerEvent!.z]
  //   );
  // }

  // double distance(List<double> numbers){
  //   double totalDistance = 0.0;
  //   for (int i = 0; i < numbers.length; i++){
  //     totalDistance = totalDistance + pow(numbers[i], 2);
  //   }
  //   totalDistance = sqrt(totalDistance);
  //   print(totalDistance);
  //   return totalDistance;
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

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