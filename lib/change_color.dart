//import 'dart:io';

//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';

// void main() {
//   FlutterError.onError = (FlutterErrorDetails details) {
//     FlutterError.dumpErrorToConsole(details);
//     if (kReleaseMode) {
//       exit(1);
//     }
//   };

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Drawing Test',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const MyHomePage(),
//     );
//   }
// }

class DrawingApp extends StatefulWidget {
  //const DrawingApp({Key? key}) : super(key: key);
  const DrawingApp({super.key, required this.title});

  final String title;

  @override
  State<DrawingApp> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DrawingApp> {

  final DrawingController _drawingController = DrawingController();

  @override
  void dispose() {
    _drawingController.dispose();
    super.dispose();
  }


  // Future<void> _getImageData() async {
  //   final Uint8List? data =
  //       (await _drawingController.getImageData())?.buffer.asUint8List();
  //   if (data == null) {
  //     debugPrint('some kind of error');
  //     return;
  //   }

  //   if (mounted) {
  //     showDialog<void>(
  //       context: context,
  //       builder: (BuildContext c) {
  //         return Material(
  //           color: Colors.transparent,
  //           child: InkWell(
  //               onTap: () => Navigator.pop(c), child: Image.memory(data)),
  //         );
  //       },
  //     );
  //   }
  // }

  // Future<void> _getJson() async {
  //   showDialog<void>(
  //     context: context,
  //     builder: (BuildContext c) {
  //       return Center(
  //         child: Material(
  //           color: Colors.white,
  //           child: InkWell(
  //             onTap: () => Navigator.pop(c),
  //             child: Container(
  //               constraints:
  //                   const BoxConstraints(maxWidth: 500, maxHeight: 800),
  //               padding: const EdgeInsets.all(20.0),
  //               child: SelectableText(
  //                 const JsonEncoder.withIndent('  ')
  //                     .convert(_drawingController.getJsonList()),
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Drawing Test'),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        // actions: <Widget>[
        //   IconButton(
        //       icon: const Icon(Icons.javascript_outlined), onPressed: _getJson),
        //   IconButton(icon: const Icon(Icons.check), onPressed: _getImageData),
        //   const SizedBox(width: 40),
        // ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return DrawingBoard(
                  // boardPanEnabled: false,
                  // boardScaleEnabled: false,
                  controller: _drawingController,
                  background: Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    color: Colors.white,
                  ),
                  showDefaultActions: true,
                  showDefaultTools: true,
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
          ),
        ],
      ),
    );
  }
}