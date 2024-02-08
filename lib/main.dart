import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VibratingSection(),
    );
  }
}

class VibratingSection extends StatefulWidget {
  @override
  _VibratingSectionState createState() => _VibratingSectionState();
}

enum DragDirection { up, down }

class _VibratingSectionState extends State<VibratingSection> {
  bool _hasVibrated = false;
  DragDirection? _dragDirection;
  double _boundary1 = 0;
  double _boundary2 = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragDown: (details) => _startDrag(details),
      onVerticalDragUpdate: (details) => _checkPosition(details),
      onVerticalDragEnd: (_) => _resetState(),
      child: Container(
        color: _hasVibrated ? Colors.green : Colors.blue,
        child: const Center(
          child: Text(
            'Drag your finger',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }

  void _startDrag(DragDownDetails details) {
    // Reset the state on the start of a new drag
    _resetState();
    // Get the boundaries based on the screen height
    final screenHeight = MediaQuery.of(context).size.height;
    _boundary1 = screenHeight / 3;
    _boundary2 = screenHeight * 2 / 3;
    // Determine the initial drag direction based on the start position
    _dragDirection = details.localPosition.dy < _boundary1
        ? DragDirection.down
        : details.localPosition.dy < _boundary2
            ? DragDirection.up
            : DragDirection.down;
  }

  void _checkPosition(DragUpdateDetails details) {
    // Get the current drag direction
    final currentDragDirection = details.localPosition.dy < _boundary1
        ? DragDirection.down
        : details.localPosition.dy < _boundary2
            ? DragDirection.up
            : DragDirection.down;

    if (_dragDirection != currentDragDirection) {
      // The drag direction has changed, and we have crossed a boundary
      setState(() {
        _hasVibrated = true;
        _vibrate();
      });
      // Update the drag direction
      _dragDirection = currentDragDirection;
    }
  }

  void _vibrate() async {
    HapticFeedback.selectionClick();
    //Vibration.vibrate(duration: 200);
  }

  void _resetState() {
    setState(() {
      _hasVibrated = false;
      _dragDirection = null;
    });
  }
}



































// import 'package:flutter/material.dart';
// import 'package:sensors_plus/sensors_plus.dart';
// import 'dart:async';
// import 'dart:math';
// import 'package:vibration/vibration.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ShakeCounterApp(),
//     );
//   }
// }

// class ShakeCounterApp extends StatefulWidget {
//   @override
//   _ShakeCounterAppState createState() => _ShakeCounterAppState();
// }

// class _ShakeCounterAppState extends State<ShakeCounterApp> {
// @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
//                       final shakeDetector = ShakeDetector();
//                       shakeDetector.stream.listen(
//                             (UserAccelerometerEvent event) async {
//                               print("shake detected!");
//                             }
//                       );
//                     },
//                     tooltip: 'Vibration',
//                     heroTag: 'btn1',
//                     child: const Icon(Icons.numbers)
//                   ),
//                 ]
//               )
//             )
//           ]
//         )
//       )
//     );
//   }
// }

// class ShakeDetector {
//   StreamSubscription<UserAccelerometerEvent>? accListener;
//   DateTime? lastProcessedTime;
//   StreamController<UserAccelerometerEvent> rmsStreamController =
//       StreamController<UserAccelerometerEvent>();
//   int shakeCount = 0;

//   ShakeDetector() {
//     bool isVibrating = false;
//     accListener = userAccelerometerEventStream().listen(
//       (UserAccelerometerEvent event) {
//         // print(event.x);
//         // print(event.y);
//         // print(event.z);
//         final rms = sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
//         // ideally add a semaphore here so that it can only call vibrate if it's not already vibrating
//         if (rms > 10) {
//           print(rms);
//           if (!isVibrating){
//             Vibration.vibrate();
//           }
//         } 
//         else{
//           Vibration.cancel();
//         }
//         // else {
//         //   shakeCount = 0;
//         // }
//       },
//       onError: (error) {
//         // Logic to handle error
//         // Needed for Android in case sensor is not available
//       },
//       cancelOnError: true,
//     );
//   }

//   Stream<UserAccelerometerEvent> get stream => rmsStreamController.stream;

//   void dispose() {
//     accListener?.cancel();
//     rmsStreamController.close();
//   }
// }



















































// import 'package:flutter/material.dart';
// import 'package:shake/shake.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ShakeCounterApp(),
//     );
//   }
// }

// class ShakeCounterApp extends StatefulWidget {
//   @override
//   _ShakeCounterAppState createState() => _ShakeCounterAppState();
// }

// class _ShakeCounterAppState extends State<ShakeCounterApp> {
//   int _counter = 0;

//   accListener = userAccelerometerEventStream().listen(
//       (UserAccelerometerEvent event) {
//         final rms = sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
        

//   @override
//   void initState() {
//     super.initState();
//     ShakeDetector.autoStart(onPhoneShake: () {
//       setState(() {
//         _counter++;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     //ShakeDetector.stopListening();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Shake Counter'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Shake your device to increment the counter:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }













































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