import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:opun_challenge/widgets/number_wheel.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final _minCounter=0;
  final _maxCounter=30;
  Color _c = Color.fromARGB(240, 227, 245, 239);

  void _incrementCounter(int inc) {
    int temp = _counter + inc;
    if (_minCounter <= temp && temp< _maxCounter ) {
      setState(() => _counter += inc);
      _c = Color.fromARGB(240, 227, 245, 239);
    }
    if (temp == _maxCounter) {
      setState(() {
        _counter += inc;
        _c = Colors.red;
      });
    }

  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: _c,
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[
                  SizedBox(
                    height: 80,
                  ),
                  // TODO: remove this counter and show capacity by animating number wheels
                  Text(
                    'Capacity:',
                  ),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(FontAwesomeIcons.userMinus),
                        onPressed: () => _incrementCounter(-1),
                      ),
                      IconButton(
                        icon: Icon(FontAwesomeIcons.userPlus),
                        onPressed: () => _incrementCounter(1),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * .5,
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        border: Border.all(width: 2.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NumberWheel(number: _counter~/10),
                          NumberWheel(number: _counter%10),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child:
                      // TODO: show business name here if it has been saved in the settings page
                      Text(widget.title,
                          style: TextStyle(fontSize: 20)),
                    ),
                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/settings'),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }
  }

