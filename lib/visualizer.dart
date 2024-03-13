import 'package:flutter/material.dart';

class Visualizer extends StatefulWidget {
  @override
  _VisualizerState createState() => _VisualizerState();
}

class _VisualizerState extends State<Visualizer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visualizer'),
      ),
      body: Stack(
        children: <Widget>[
          // Your main content goes here
          Center(child: Text('Main Content')),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100, // Adjust this to change the height of the visualizer
              color: Colors.grey[200], // Background color for visualizer
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FadeTransition(
                    opacity: _animationController,
                    child: Icon(Icons.mic, color: Colors.red, size: 30),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Slide to Cancel",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
