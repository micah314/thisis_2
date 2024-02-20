import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sensors Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0x9f4376f8),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const Duration _ignoreDuration = Duration(milliseconds: 20);

  static const int _snakeRows = 20;
  static const int _snakeColumns = 20;
  static const double _snakeCellSize = 10.0;

  UserAccelerometerEvent? _userAccelerometerEvent;
  AccelerometerEvent? _accelerometerEvent;
  GyroscopeEvent? _gyroscopeEvent;
  MagnetometerEvent? _magnetometerEvent;

  DateTime? _userAccelerometerUpdateTime;
  DateTime? _accelerometerUpdateTime;
  DateTime? _gyroscopeUpdateTime;
  DateTime? _magnetometerUpdateTime;

  int? _userAccelerometerLastInterval;
  int? _accelerometerLastInterval;
  int? _gyroscopeLastInterval;
  int? _magnetometerLastInterval;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  Duration sensorInterval = SensorInterval.normalInterval;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensors Plus Example'),
        elevation: 4,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.black38),
              ),
              child: const SizedBox(
                height: _snakeRows * _snakeCellSize,
                width: _snakeColumns * _snakeCellSize,
              ),
            ),
),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(4),
                4: FlexColumnWidth(2),
              },
              children: [
                const TableRow(
                  children: [
                    SizedBox.shrink(),
                    Text('X'),
                    Text('Y'),
                    Text('Z'),
                    Text('Interval'),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('UserAccelerometer'),
                    ),
                    Text(_userAccelerometerEvent?.x.toStringAsFixed(1) ?? '?'),
                    Text(_userAccelerometerEvent?.y.toStringAsFixed(1) ?? '?'),
                    Text(_userAccelerometerEvent?.z.toStringAsFixed(1) ?? '?'),
                    Text(
                        '${_userAccelerometerLastInterval?.toString() ?? '?'} ms'),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Accelerometer'),
                    ),
                    Text(_accelerometerEvent?.x.toStringAsFixed(1) ?? '?'),
                    Text(_accelerometerEvent?.y.toStringAsFixed(1) ?? '?'),
                    Text(_accelerometerEvent?.z.toStringAsFixed(1) ?? '?'),
                    Text('${_accelerometerLastInterval?.toString() ?? '?'} ms'),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Gyroscope'),
                    ),
                    Text(_gyroscopeEvent?.x.toStringAsFixed(1) ?? '?'),
                    Text(_gyroscopeEvent?.y.toStringAsFixed(1) ?? '?'),
                    Text(_gyroscopeEvent?.z.toStringAsFixed(1) ?? '?'),
                    Text('${_gyroscopeLastInterval?.toString() ?? '?'} ms'),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Magnetometer'),
                    ),
                    Text(_magnetometerEvent?.x.toStringAsFixed(1) ?? '?'),
                    Text(_magnetometerEvent?.y.toStringAsFixed(1) ?? '?'),
                    Text(_magnetometerEvent?.z.toStringAsFixed(1) ?? '?'),
                    Text('${_magnetometerLastInterval?.toString() ?? '?'} ms'),
                  ],
                ),
              ],
            ),
          ),
        ]
      )
    );
  }
}










//CIRCLE THING!!!!!!!!!!!!!
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Expanding Circle',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: ExpandingCirclePage(),
//     );
//   }
// }

// class ExpandingCirclePage extends StatefulWidget {
//   @override
//   _ExpandingCirclePageState createState() => _ExpandingCirclePageState();
// }

// class _ExpandingCirclePageState extends State<ExpandingCirclePage>
//     with SingleTickerProviderStateMixin {
//   double _radius = 50.0;
//   double _frequencyExpand = 1;
//   double _frequencyContract = 4/6;
//   late AnimationController _controllerExpand;
//   late AnimationController _controllerContract;

//   @override
//   void initState() {
//     super.initState();
//     _controllerExpand =
//         AnimationController(vsync: this, duration: const Duration(seconds: 1))
//           ..addListener(() {
//             setState(() {
//               _radius = 50.0 + 50.0 * _controllerExpand.value;
//             });
//           })
//           ..repeat(reverse: true);
//   }

//   @override
//   void dispose() {
//     _controllerExpand.dispose();
//     _controllerContract.dispose();
//     super.dispose();
//   }

//   void _changeFrequency(double value) {
//     setState(() {
//       _frequencyExpand = value;
//       _frequencyContract = value * 4/6;
//       _controllerExpand.duration = Duration(milliseconds: (1000 ~/ _frequencyExpand).toInt());
//       _controllerExpand.repeat(reverse: true);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Expanding Circle'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               width: _radius * 2,
//               height: _radius * 2,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.blue,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text('Frequency: ${_frequencyExpand.toStringAsFixed(2)} Hz'),
//             Slider(
//               value: _frequencyExpand,
//               min: 0.1,
//               max: 5.0,
//               divisions: 50,
//               onChanged: _changeFrequency,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }























// import 'package:flutter/material.dart';
// import 'package:vibration/vibration.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_application_1/screen_three.dart';
// import 'package:flutter_application_1/screen_two.dart';
// import 'package:flutter_application_1/change_color.dart';
// import 'package:audioplayers/audioplayers.dart';


// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // return Scaffold(
//     //   body: VibratingSection(),
//     // );
//     return Stack(
//       children:[
//         VibratingSection(),
        
//       ]
//     );
//   }
// }





// class VibratingSection extends StatefulWidget {
//   @override
//   _VibratingSectionState createState() => _VibratingSectionState();
// }

// enum DragDirection { up, down }

// class _VibratingSectionState extends State<VibratingSection> {
//   bool _hasVibrated = false;
//   DragDirection? _dragDirection;
//   double _boundary1 = 0;
//   double _boundary2 = 0;
//   final player = AudioPlayer();

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     return GestureDetector (
//       onVerticalDragDown: (details) => _startDrag(details, screenHeight),
//       onVerticalDragUpdate: (details) => _checkPosition(details),
//       onVerticalDragEnd: (_) => _resetState(),
//       child: Container (
//         color: _hasVibrated ? Colors.green : Colors.blue,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 height: screenHeight / 3, 
//                 child: GestureDetector(
//                   onTap: () {
//                     player.play(AssetSource('c.mp3')); 

//                     Vibration.vibrate(duration: 10);
//                   },
//                   onDoubleTap: () {
//                       Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const SecondRoute(
//                           title: "New Screen",
//                         )
//                       )
//                     );
//                   }
//                 ),
//               ),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 height: screenHeight / 3, 
//                 child: GestureDetector(
//                   onTap: () {Vibration.vibrate(duration: 2);},
//                   onDoubleTap: () {
//                       Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const ThirdRoute(
//                           title: "New Screen",
//                         )
//                       )
//                     );
//                   }
//                 ),
//               ),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 height: screenHeight / 3, 
//                 child: GestureDetector(
//                   onTap: () {Vibration.vibrate(duration: 2);}
//                 ),
//               ),
//             ]
//           )
//       ),
//     );
//   }

//   void _startDrag(DragDownDetails details, double screenHeight) {
//     // Reset the state on the start of a new drag
//     _resetState();
//     // Get the boundaries based on the screen height
//     _boundary1 = screenHeight / 3;
//     _boundary2 = screenHeight * 2 / 3;
//     // Determine the initial drag direction based on the start position
//     _dragDirection = details.localPosition.dy < _boundary1
//         ? DragDirection.down
//         : details.localPosition.dy < _boundary2
//             ? DragDirection.up
//             : DragDirection.down;
//   }

//   void _checkPosition(DragUpdateDetails details) {
//     // Get the current drag direction
//     final currentDragDirection = details.localPosition.dy < _boundary1
//         ? DragDirection.down
//         : details.localPosition.dy < _boundary2
//             ? DragDirection.up
//             : DragDirection.down;

//     if (_dragDirection != currentDragDirection) {
//       // The drag direction has changed, and we have crossed a boundary
//       setState(() {
//         _hasVibrated = true;
//         _vibrate();
//       });
//       // Update the drag direction
//       _dragDirection = currentDragDirection;
//     }
//   }

//   void _vibrate() async {
//     //HapticFeedback.selectionClick();
//     Vibration.vibrate(duration: 10);
//   }

//   void _resetState() {
//     setState(() {
//       _hasVibrated = false;
//       _dragDirection = null;
//     });
//   }
// }







// class VibratingSection2 extends StatefulWidget {
//   @override
//   _VibratingSectionState2 createState() => _VibratingSectionState2();
// }

// class _VibratingSectionState2 extends State<VibratingSection> {
//   bool _hasVibrated = false;

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: GestureDetector(
//         onPanStart: (_) => _vibrateOnce(),
//         child: Container(
//           color: Colors.blue,
//           child: const Center(
//             child: Text(
//               'Touch to Vibrate',
//               style: TextStyle(color: Colors.white, fontSize: 20),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _vibrateOnce() async {
//     if (!_hasVibrated) {
//       Vibration.vibrate(duration: 200);
//       setState(() {
//         _hasVibrated = true;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _hasVibrated = false;
//   }
// }



































