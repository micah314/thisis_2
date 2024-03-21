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
      home: ExpandingCircle(),
    );
  }
}

class ExpandingCircle extends StatefulWidget {
  @override
  _ExpandingCircleState createState() => _ExpandingCircleState();
}

class _ExpandingCircleState extends State<ExpandingCircle> with SingleTickerProviderStateMixin {
  double _radius = 50.0;
  double _frequency1 = 1.0; // Frequency of the first animation
  double _frequency2 = 0.5; // Frequency of the second animation

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);
    _controller.addListener(() {
      setState(() {
        _radius = 50.0 + 25.0 * _controller.value * (1 + _frequency1 * 2 * 3.14); // Adjust radius with first frequency
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expanding Circle'),
      ),
      body: Center(
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          width: _radius * 2,
          height: _radius * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _controller.stop();
              _controller.reset();
              _controller.repeat(reverse: true);
            },
            child: Icon(Icons.play_arrow),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              _controller.stop();
            },
            child: Icon(Icons.pause),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _frequency1 += 0.1;
              });
            },
            child: Icon(Icons.add),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _frequency1 -= 0.1;
                if (_frequency1 < 0) _frequency1 = 0;
              });
            },
            child: Icon(Icons.remove),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _frequency2 += 0.1;
              });
            },
            child: Icon(Icons.add),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _frequency2 -= 0.1;
                if (_frequency2 < 0) _frequency2 = 0;
              });
            },
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}






