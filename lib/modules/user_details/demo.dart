import 'package:flutter/material.dart';

Tween<double> _tween = Tween(begin: 0.1, end: 1);

class ScaleTransitionExample extends StatefulWidget {
  _ScaleTransitionExampleState createState() => _ScaleTransitionExampleState();
}

class _ScaleTransitionExampleState extends State<ScaleTransitionExample>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  Tween<double> _tween = Tween(begin: 0.1, end: 1);

  initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Center(
            child: ScaleTransition(
              scale: _tween.animate(
                  CurvedAnimation(parent: _controller, curve: Curves.ease)),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check, size: 100.0, color: Colors.green),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: RaisedButton(
              child: Text('forward'),
              onPressed: () => _controller.forward(),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: RaisedButton(
              child: Text('reverse'),
              onPressed: () => _controller.reverse(),
            ),
          ),
        ],
      ),
    );
  }
}
