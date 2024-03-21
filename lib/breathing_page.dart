import 'package:flutter/material.dart';

class ExpandingCircle extends StatefulWidget {
  const ExpandingCircle({super.key, required this.title});

  final String title;

  @override
  _ExpandingCircleState createState() => _ExpandingCircleState();
}


class _ExpandingCircleState extends State<ExpandingCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _sliderValue = 3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3), // Total duration for one cycle
    )..repeat(reverse: true); // Reverses animation at the end
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateCircleSize(double value) {
    setState(() {
      _sliderValue = value;
      _controller.duration = Duration(seconds: (value).round()); // Adjust the multiplier as needed
      _controller.repeat(reverse: true); // Restart animation with new duration
    });
  }

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Container(
                  width: 100.0 + (_animation.value * 150.0), // Adjust the multiplier as needed
                  height: 100.0 + (_animation.value * 150.0), // Adjust the multiplier as needed
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Slider(
              value: _sliderValue,
              min: 1,
              max: 6,
              onChanged: _updateCircleSize,
            ),
          ],
        ),
      ),
    );
  }
}




























// class _ExpandingCircleState extends State<ExpandingCircle> with SingleTickerProviderStateMixin {
//   double _radius = 50.0;
//   double _frequency1 = 1.0; // Frequency of the first animation
//   double _frequency2 = 0.5; // Frequency of the second animation

//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 1),
//     )..repeat(reverse: true);
//     _controller.addListener(() {
//       setState(() {
//         _radius = 50.0 + 25.0 * _controller.value * (1 + _frequency1 * 2 * 3.14); // Adjust radius with first frequency
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Expanding Circle'),
//       ),
//       body: Center(
//         child: AnimatedContainer(
//           duration: Duration(seconds: 1),
//           width: _radius * 2,
//           height: _radius * 2,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.blue,
//           ),
//         ),
//       ),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             onPressed: () {
//               _controller.stop();
//               _controller.reset();
//               _controller.repeat(reverse: true);
//             },
//             child: Icon(Icons.play_arrow),
//           ),
//           SizedBox(height: 16),
//           FloatingActionButton(
//             onPressed: () {
//               _controller.stop();
//             },
//             child: Icon(Icons.pause),
//           ),
//           SizedBox(height: 16),
//           FloatingActionButton(
//             onPressed: () {
//               setState(() {
//                 _frequency1 += 0.1;
//               });
//             },
//             child: Icon(Icons.add),
//           ),
//           SizedBox(height: 16),
//           FloatingActionButton(
//             onPressed: () {
//               setState(() {
//                 _frequency1 -= 0.1;
//                 if (_frequency1 < 0) _frequency1 = 0;
//               });
//             },
//             child: Icon(Icons.remove),
//           ),
//           SizedBox(height: 16),
//           FloatingActionButton(
//             onPressed: () {
//               setState(() {
//                 _frequency2 += 0.1;
//               });
//             },
//             child: Icon(Icons.add),
//           ),
//           SizedBox(height: 16),
//           FloatingActionButton(
//             onPressed: () {
//               setState(() {
//                 _frequency2 -= 0.1;
//                 if (_frequency2 < 0) _frequency2 = 0;
//               });
//             },
//             child: Icon(Icons.remove),
//           ),
//         ],
//       ),
//     );
//   }
// }






