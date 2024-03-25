

// import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class ThirdRoute2 extends StatefulWidget {
  const ThirdRoute2({super.key, required this.title});

  final String title;

  @override
  State<ThirdRoute2> createState() => _ThirdRouteState2();
}

// This is the actual function that's important
class _ThirdRouteState2 extends State<ThirdRoute2>{
  double circleRadius = 50.0;
  Offset circleCenter = const Offset(0, 0);
  Offset center = const Offset(0, 0);
  int currentVibration = 0;
  
  bool vibrationSpeed = true;

  final double _opacity = 1.0; //here
  

  void onPanStart(DragStartDetails details) {
    print('User started drawing');
    final box = context.findRenderObject() as RenderBox;
    final point = box.globalToLocal(details.globalPosition);
    setState(() {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      //circleCenter = Offset(200, 200); // as you gesture point the circle towards the point 200, 200 it gets smaller
      final newCircleCenter = renderBox.globalToLocal(details.globalPosition);
      Offset center = Offset(newCircleCenter.dx, newCircleCenter.dy - 200);
      // circleCenter = newCircleCenter;
      circleCenter = center;
      vibrationSpeed = true;
    }); //start on a low speed
    print(point);
  }

  void onPanUpdate(DragUpdateDetails details) {
    final box = context.findRenderObject() as RenderBox;
    final delta = box.globalToLocal(details.delta);
    print(delta.distance);
    int distanceThreshold = 10;
    setState(() {
      print(vibrationSpeed);
      if (delta.distance < distanceThreshold && vibrationSpeed == true){
        print("here");
        Vibration.cancel();
        Vibration.vibrate(amplitude: 5, duration: 200000000);
        vibrationSpeed = false;
      }
      else if (delta.distance > distanceThreshold && vibrationSpeed == false){
        print("here 2");
        Vibration.cancel();
        Vibration.vibrate(amplitude: 100, duration: 200000000);
        vibrationSpeed = true;
      }
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      final newCircleCenter = renderBox.globalToLocal(details.globalPosition);
      final distance = _calculateDistance(newCircleCenter, circleCenter);
      circleRadius = distance.clamp(10.0, 200.0);
      center = Offset(newCircleCenter.dx, newCircleCenter.dy - 200);
      circleCenter = newCircleCenter;
    });
  }

  void onPanEnd(DragEndDetails details) {
    Vibration.cancel();
    print('User ended drawing');
  }


  // Build method. This is where the actual app is built
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: AnimatedOpacity( //here
          duration: const Duration( //here
            seconds: 3, //here
          ), //here
          opacity: _opacity, //here
          child: GestureDetector(
            onPanStart: onPanStart,
            onPanUpdate: onPanUpdate,
            onPanEnd: onPanEnd,
            child: CustomPaint(
              //painter: CirclePainter(center: circleCenter, radius: circleRadius),
              painter: CirclePainter(center: center, radius: circleRadius),
              size: const Size(400, 400),
            ),
          ),
        ),
      ),
    );
  }
  double _calculateDistance(Offset a, Offset b) {
    return (a - b).distance * 2;
  }
}

class CirclePainter extends CustomPainter {
  final Offset center;
  final double radius;

  CirclePainter({required this.center, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 5.0;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}