import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expanding Circle',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExpandingCirclePage(),
    );
  }
}

class ExpandingCirclePage extends StatefulWidget {
  @override
  _ExpandingCirclePageState createState() => _ExpandingCirclePageState();
}

class _ExpandingCirclePageState extends State<ExpandingCirclePage>
    with SingleTickerProviderStateMixin {
  double _radius = 50.0;
  double _frequency = 1.0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..addListener(() {
            setState(() {
              _radius = 50.0 + 50.0 * _controller.value;
            });
          })
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _changeFrequency(double value) {
    setState(() {
      _frequency = value;
      _controller.duration = Duration(milliseconds: (1000 ~/ _frequency).toInt());
      _controller.repeat(reverse: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expanding Circle'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: _radius * 2,
              height: _radius * 2,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            Text('Frequency: ${_frequency.toStringAsFixed(2)} Hz'),
            Slider(
              value: _frequency,
              min: 0.1,
              max: 5.0,
              divisions: 50,
              onChanged: _changeFrequency,
            ),
          ],
        ),
      ),
    );
  }
}























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



































