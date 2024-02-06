import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShakeCounterApp(),
    );
  }
}

class ShakeCounterApp extends StatefulWidget {
  @override
  _ShakeCounterAppState createState() => _ShakeCounterAppState();
}

class _ShakeCounterAppState extends State<ShakeCounterApp> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    ShakeDetector.autoStart(onPhoneShake: () {
      setState(() {
        _counter++;
      });
    });
  }

  @override
  void dispose() {
    //ShakeDetector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shake Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Shake your device to increment the counter:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}













































// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/screen_three.dart';
// import 'package:flutter_application_1/screen_two.dart';
// import 'package:flutter_application_1/change_color.dart';

// void main() {
//   runApp(const MyApp());
// }



// class MyApp extends StatelessWidget {
  
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
    
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
  
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {

//   void _newScreen() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const SecondRoute(
//           title: "New Screen",
//         )
//       )
//     );
//   }



//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Expanded(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   FloatingActionButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const SecondRoute(
//                             title: "New Screen",
//                           )
//                         )
//                       );
//                     },
//                     tooltip: 'Vibration',
//                     heroTag: 'btn1',
//                     child: const Icon(Icons.numbers)
//                   ),
//                   FloatingActionButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const DrawingApp(
//                             title: "New Screen",
//                           )
//                         )
//                       );
//                     },
//                     tooltip: 'Vibration 2',
//                     heroTag: 'btn2',
//                     child: const Icon(Icons.add)
//                   ),
//                 ]
//               )
//             ),
//             Expanded(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   FloatingActionButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const ThirdRoute(
//                             title: "New Screen",
//                           )
//                         )
//                       );
//                     },
//                     tooltip: 'Vibration 2',
//                     heroTag: 'btn2',
//                     child: const Icon(Icons.add)
//                   ),
//                   FloatingActionButton(
//                     onPressed: _newScreen,
//                     tooltip: 'Vibration 2',
//                     heroTag: 'btn5',
//                     child: const Icon(Icons.add)
//                   ),
//                 ]
//               )
//             ),
//             Expanded(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   FloatingActionButton(
//                     onPressed: _newScreen,
//                     tooltip: 'Vibration',
//                     heroTag: 'btn7',
//                     child: const Icon(Icons.add)
//                   ),
//                   FloatingActionButton(
//                     onPressed: _newScreen,
//                     tooltip: 'Vibration 2',
//                     heroTag: 'btn8',
//                     child: const Icon(Icons.add)
//                   ),
//                 ]
//               )
//             ),
//           ]
//         )
//       )
//     );      
//   }
// }






























// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   double circleRadius = 50.0;
//   Offset circleCenter = Offset(0, 0);
//   Offset center = Offset(0, 0);

//   double _opacity = 1.0; //here


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Resizable Circle App'),
//       ),
//       body: Center(
//         child: AnimatedOpacity( //here
//           duration: const Duration( //here
//             seconds: 3, //here
//           ), //here
//           opacity: _opacity, //here
//           child: GestureDetector(
//             onPanStart:(details){
//               setState(() {
//                 final RenderBox renderBox = context.findRenderObject() as RenderBox;
//                 //circleCenter = Offset(200, 200); // as you gesture point the circle towards the point 200, 200 it gets smaller
//                 final newCircleCenter = renderBox.globalToLocal(details.globalPosition);
//                 Offset center = Offset(newCircleCenter.dx, newCircleCenter.dy - 200);
//                 // circleCenter = newCircleCenter;
//                 circleCenter = center;
//               });
//             },
//             onPanUpdate: (details) {
//               setState(() {
//                 final RenderBox renderBox = context.findRenderObject() as RenderBox;
//                 //circleCenter = Offset(200, 200); // as you gesture point the circle towards the point 200, 200 it gets smaller
//                 final newCircleCenter = renderBox.globalToLocal(details.globalPosition);
//                 final distance = _calculateDistance(newCircleCenter, circleCenter);
//                 print(distance);
//                 circleRadius = distance.clamp(10.0, 200.0);
//                 center = Offset(newCircleCenter.dx, newCircleCenter.dy - 200);
//                 circleCenter = newCircleCenter;
//                 // circleCenter = center;
//                 //_opacity = _opacity == 1 ? 0 : 1; //here
//               });
//             },
//             child: CustomPaint(
//               //painter: CirclePainter(center: circleCenter, radius: circleRadius),
//               painter: CirclePainter(center: center, radius: circleRadius),
//               size: Size(400, 400),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   double _calculateDistance(Offset a, Offset b) {
//     return (a - b).distance * 2;
//   }
// }

// class CirclePainter extends CustomPainter {
//   final Offset center;
//   final double radius;

//   CirclePainter({required this.center, required this.radius});

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Colors.blue
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 5.0;

//     canvas.drawCircle(center, radius, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }