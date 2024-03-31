import 'package:bbooking/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'visualizer.dart';
import 'home.dart';
import 'sign_in_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  bool _showVisualizer = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Stack(
        children: <Widget>[
          Center(child: Text('Press and Hold')),
          if (_showVisualizer)
            Align(
              alignment: Alignment.bottomCenter,
              child: Visualizer(),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onLongPress: () {
                  setState(() {
                    _showVisualizer = true;
                  });
                },
                onLongPressEnd: (details) {
                  setState(() {
                    _showVisualizer = false;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Text(
                    'Press and Hold',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
