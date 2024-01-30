import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen_three.dart';
import 'package:flutter_application_1/screen_two.dart';
import 'package:flutter_application_1/change_color.dart';

void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _newScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SecondRoute(
          title: "New Screen",
        )
      )
    );
  }



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SecondRoute(
                            title: "New Screen",
                          )
                        )
                      );
                    },
                    tooltip: 'Vibration',
                    heroTag: 'btn1',
                    child: const Icon(Icons.numbers)
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DrawingApp(
                            title: "New Screen",
                          )
                        )
                      );
                    },
                    tooltip: 'Vibration 2',
                    heroTag: 'btn2',
                    child: const Icon(Icons.add)
                  ),
                ]
              )
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ThirdRoute(
                            title: "New Screen",
                          )
                        )
                      );
                    },
                    tooltip: 'Vibration 2',
                    heroTag: 'btn2',
                    child: const Icon(Icons.add)
                  ),
                  FloatingActionButton(
                    onPressed: _newScreen,
                    tooltip: 'Vibration 2',
                    heroTag: 'btn5',
                    child: const Icon(Icons.add)
                  ),
                ]
              )
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: _newScreen,
                    tooltip: 'Vibration',
                    heroTag: 'btn7',
                    child: const Icon(Icons.add)
                  ),
                  FloatingActionButton(
                    onPressed: _newScreen,
                    tooltip: 'Vibration 2',
                    heroTag: 'btn8',
                    child: const Icon(Icons.add)
                  ),
                ]
              )
            ),
          ]
        )
      )
    );      
  }
}