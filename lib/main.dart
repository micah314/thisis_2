
// MAIN THING!!!!!

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_application_1/circle_page.dart';
import 'package:flutter_application_1/numbers_page.dart';
import 'package:flutter_application_1/sensors_page.dart';
import 'package:audioplayers/audioplayers.dart';


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
    // return Scaffold(
    //   body: VibratingSection(),
    // );
    return Stack(
      children:[
        VibratingSection(),
        
      ]
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
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector (
      onVerticalDragDown: (details) => _startDrag(details, screenHeight),
      onVerticalDragUpdate: (details) => _checkPosition(details),
      onVerticalDragEnd: (_) => _resetState(),
      child: Container (
        color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: screenHeight / 3 - 5, 
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    player.play(AssetSource('c.mp3')); 

                    Vibration.vibrate(duration: 10);
                  },
                  onDoubleTap: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SecondRoute(
                          title: "New Screen",
                        )
                      )
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: screenHeight / 6,
                      ),
                      const Text("hi"),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 10, 
                color: Colors.white
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: screenHeight / 3 - 10, 
                child: GestureDetector(
                  onTap: () {Vibration.vibrate(duration: 2);},
                  onDoubleTap: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ThirdRoute(
                          title: "New Screen",
                        )
                      )
                    );
                  }
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 10, 
                color: Colors.white
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: screenHeight / 3 - 5, 
                child: GestureDetector(
                  onTap: () {Vibration.vibrate(duration: 2);},
                  onDoubleTap: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DrawingApp(
                          title: "New Screen",
                        )
                      )
                    );
                  }
                ),
              ),
            ]
          )
      ),
    );
  }

  void _startDrag(DragDownDetails details, double screenHeight) {
    // Reset the state on the start of a new drag
    _resetState();
    // Get the boundaries based on the screen height
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
    //HapticFeedback.selectionClick();
    Vibration.vibrate(duration: 10);
  }

  void _resetState() {
    setState(() {
      _hasVibrated = false;
      _dragDirection = null;
    });
  }
}







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
//           color: Colors.black,
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



































