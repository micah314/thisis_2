import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

// Creates a state
class SecondRoute extends StatefulWidget {
  const SecondRoute({super.key, required this.title});

  final String title;

  @override
  State<SecondRoute> createState() => _SecondRouteState();
}

// This is the actual function that's important
class _SecondRouteState extends State<SecondRoute>{

  int _counter = 0;

  // Functions that change the state a put here
  void _incrementCounter() {
    for (int i = 0; i < 10; i++){
    setState(() {
      _counter++;
    });
    }
  }
  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }
  void _vibrate(){
    setState(() {
      Vibration.vibrate(amplitude: 40, duration: 4000);
    });
  }
  void _vibrateLow(){
    setState(() {
      Vibration.vibrate(amplitude: 20, duration: 4000);
    });
  }


  // Build method. This is where the actual app is built
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The top bar of the app
      appBar: AppBar(
        title: const Text('Second Route'),
      ),

      // The main body of the app
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            // Row 1 (top third)
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: _decrementCounter,
                    tooltip: 'Decrement',
                    child: const Icon(Icons.remove),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FloatingActionButton(
                    onPressed: _incrementCounter,
                    tooltip: 'Increment',
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FloatingActionButton(
                    onPressed: _vibrate,
                    tooltip: 'Vibration',
                    child: const Icon(Icons.filter_list)
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FloatingActionButton(
                    onPressed: _vibrateLow,
                    tooltip: 'Vibration',
                    child: const Icon(Icons.filter_list)
                  ),
                  const SizedBox(
                    width: 20,
                  )
                ]
              )
            ),

            // Row 2 (middle third)
            Expanded( 
              child: Column( 
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Your counter is at:',
                  ),
                  // s2.buttonSection,
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ]
              )
            ),

            // Row 3 (bottom third)
            Expanded(
              // This is the gesture decector that detects when swiping left or right
              child: SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    if (details.delta.dx > 0){
                      _incrementCounter();
                    }
                    else if (details.delta.dy > 0){
                    }
                    else if (details.delta.dy < 0){
                    }
                    else{
                      _decrementCounter();
                    }
                  },
                )
              )
            )
          ]
        )
      ),
    );
  }
}