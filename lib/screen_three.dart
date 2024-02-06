// import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class ThirdRoute extends StatefulWidget {
  const ThirdRoute({super.key, required this.title});

  final String title;

  @override
  State<ThirdRoute> createState() => _ThirdRouteState();
}

// This is the actual function that's important
class _ThirdRouteState extends State<ThirdRoute>{
  double circleRadius = 50.0;
  Offset circleCenter = const Offset(0, 0);
  Offset center = const Offset(0, 0);

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
    });
    print(point);
  }

  void onPanUpdate(DragUpdateDetails details) {
    final box = context.findRenderObject() as RenderBox;
    final delta = box.globalToLocal(details.delta);
    double amp = delta.distance * 7 + 1;
    if (amp > 255) {amp = 255;}
    setState(() {
      Vibration.vibrate(amplitude: amp.toInt(), duration: 50);
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      //circleCenter = Offset(200, 200); // as you gesture point the circle towards the point 200, 200 it gets smaller
      final newCircleCenter = renderBox.globalToLocal(details.globalPosition);
      final distance = _calculateDistance(newCircleCenter, circleCenter);
      print(distance);
      circleRadius = distance.clamp(10.0, 200.0);
      center = Offset(newCircleCenter.dx, newCircleCenter.dy - 200);
      circleCenter = newCircleCenter;
      // circleCenter = center;
      //_opacity = _opacity == 1 ? 0 : 1; //here
    });
    print(delta.distance);
    print(amp.toInt());
  }

  void onPanEnd(DragEndDetails details) {
    print('User ended drawing');
  }


  // Build method. This is where the actual app is built
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resizable Circle App'),
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
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}







































// // import 'package:flutter/services.dart';
// import 'package:flutter/material.dart';
// import 'package:vibration/vibration.dart';

// class ThirdRoute extends StatefulWidget {
//   const ThirdRoute({super.key, required this.title});

//   final String title;

//   @override
//   State<ThirdRoute> createState() => _ThirdRouteState();
// }

// // This is the actual function that's important
// class _ThirdRouteState extends State<ThirdRoute>{
//   MyCustomPainter painter = MyCustomPainter();
  

//   void onPanStart(DragStartDetails details) {
//     print('User started drawing');
//     final box = context.findRenderObject() as RenderBox;
//     final point = box.globalToLocal(details.globalPosition);
//     print(point);
//   }

//   void onPanUpdate(DragUpdateDetails details) {
//     final box = context.findRenderObject() as RenderBox;
//     final delta = box.globalToLocal(details.delta);
//     double amp = delta.distance * 7 + 1;
//     if (amp > 255) {amp = 255;}
//     setState(() {
//       Vibration.vibrate(amplitude: amp.toInt(), duration: 50);
//       painter.addPoint(details.localPosition);
//     });
//     print(delta.distance);
//     print(amp.toInt());
//   }

//   void onPanEnd(DragEndDetails details) {
//     print('User ended drawing');
//   }


//   // Build method. This is where the actual app is built
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onPanStart: onPanStart,
//       onPanUpdate: onPanUpdate,
//       onPanEnd: onPanEnd,
     
//       child: CustomPaint(
//         painter: painter,
//         child: Container()
//       ),
//     );
//   }
// }

// class MyCustomPainter extends CustomPainter {
//   List<Offset> points = [];

//   void addPoint(Offset point) {
//     points.add(point);
//   }

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Color.fromARGB(255, 255, 0, 0)
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = 20.0;

//     Path path = Path();
//     if (points.isNotEmpty) {
//       path.moveTo(points.first.dx, points.first.dy);
//       for (Offset point in points) {
//         path.lineTo(point.dx, point.dy);
//       }
//     }

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
