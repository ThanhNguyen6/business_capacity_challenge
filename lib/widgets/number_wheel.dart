
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class NumberWheel extends StatefulWidget {
  final int number;

  const NumberWheel({Key key, this.number}) : super(key: key);

  @override
  _NumberWheelState createState() => _NumberWheelState();
}

class _NumberWheelState extends State<NumberWheel> {
  static const double IMAGE_SIZE = 120;

  Timer timer;
  double _angle = 0;

  @override
  void initState() {
    timer = Timer.periodic(Duration(milliseconds: 20), (timer) {
    //  setState(() => _angle += .01);
      setState(() {
        _angleCal(widget.number);
      });
    });

    super.initState();
  }

  void _angleCal(int num) {
    double oneAngle = pi/5;
    switch(num) {

      case 1: {  _angle = oneAngle * 8; }
      break;

      case 2: {  _angle = oneAngle * 4;  }
      break;

      case 3: {  _angle = oneAngle * 6;  }
      break;

      case 4: {  _angle = 0;  }
      break;

      case 5: {  _angle = oneAngle * 2; }
      break;

      case 6: {  _angle = oneAngle * 7;}
      break;

      case 7: {  _angle = oneAngle * 3; }
      break;

      case 8: {  _angle = oneAngle * 9;}
      break;

      case 9: {  _angle = oneAngle * 1; }
      break;

      default: { _angle = oneAngle * 5; }
      break;
    }
  }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: IMAGE_SIZE + 40,
      height: IMAGE_SIZE + 40,
      child: Stack(
        children: [
          Center(
            child: Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.rotationZ(_angle),
              child: Image(
                  width: IMAGE_SIZE,
                  height: IMAGE_SIZE,
                  image: AssetImage('assets/numbers_jumbled.png')),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_downward),
            ],
          )
        ],
      ),
    );
  }
}
