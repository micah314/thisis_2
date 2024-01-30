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
  MyCustomPainter painter = MyCustomPainter();
  

  void onPanStart(DragStartDetails details) {
    print('User started drawing');
    final box = context.findRenderObject() as RenderBox;
    final point = box.globalToLocal(details.globalPosition);
    print(point);
  }

  void onPanUpdate(DragUpdateDetails details) {
    final box = context.findRenderObject() as RenderBox;
    final delta = box.globalToLocal(details.delta);
    double amp = delta.distance * 7 + 1;
    if (amp > 255) {amp = 255;}
    setState(() {
      Vibration.vibrate(amplitude: amp.toInt(), duration: 50);
      painter.addPoint(details.localPosition);
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
    return GestureDetector(
      onPanStart: onPanStart,
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
     
      child: CustomPaint(
        painter: painter,
        child: Container()
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  List<Offset> points = [];

  void addPoint(Offset point) {
    points.add(point);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color.fromARGB(255, 255, 0, 0)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20.0;

    Path path = Path();
    if (points.isNotEmpty) {
      path.moveTo(points.first.dx, points.first.dy);
      for (Offset point in points) {
        path.lineTo(point.dx, point.dy);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

