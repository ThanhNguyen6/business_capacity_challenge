import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:opun_challenge/core/viewmodels/CRUDModel.dart';
import 'package:opun_challenge/widgets/number_wheel.dart';
import '../core/models/businessInfo.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _minCounter=0;
  int _counter=0;
  Color _c = Color.fromARGB(240, 227, 245, 239);

  int _incrementCounter(int inc, int _maxCounter, int counter) {
    int temp = _counter + inc;
    if (_minCounter <= temp && temp< _maxCounter ) {
      setState(() => _counter += inc);
      _c = Color.fromARGB(240, 227, 245, 239);
      return temp;
    }
    if (temp == _maxCounter) {
      setState(() {
        _counter += inc;
        _c = Colors.red;
      });
      return temp;
    }
    return _counter;

  }

    @override
    Widget build(BuildContext context) {
      final crudProvider = Provider.of<CRUDModel>(context);
      var name;
      var capacity;

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
                    'Current Count:',
                  ),
                  //Text(
                  //  '$currentCount',
                  //  style: Theme.of(context).textTheme.headline4,
                  //),
                  Flexible(
                      child: new StreamBuilder<DocumentSnapshot>(
                          stream: crudProvider.fetchBusinessDocAsStream('test'),
                          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Text(
                                '$_counter',
                                style: Theme.of(context).textTheme.headline4,
                              );
                            }
                            _counter = snapshot.data.data()['count'];
                            capacity = snapshot.data.data()['capacity'];
                            return Text('$_counter', style: Theme.of(context).textTheme.headline4);
                          })
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(FontAwesomeIcons.userMinus),
                        onPressed: () async {
                            int updateCount = _incrementCounter(-1, capacity, _counter);
                            await crudProvider.updateBusiness(Business(name:name, capacity: capacity, count: updateCount), 'test');
                            },
                      ),
                      IconButton(
                        icon: Icon(FontAwesomeIcons.userPlus),
                        onPressed: () async {
                          int updateCount = _incrementCounter(1, capacity, _counter);
                          await crudProvider.updateBusiness(Business(name:name, capacity: capacity, count: updateCount), 'test');
                        },
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
                          Flexible(
                              child: new StreamBuilder<DocumentSnapshot>(
                                  stream: crudProvider.fetchBusinessDocAsStream('test'),
                                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                                    if (!snapshot.hasData) {
                                      return NumberWheel(number: _counter~/10);
                                    }
                                    _counter = snapshot.data.data()['count'];
                                    capacity = snapshot.data.data()['capacity'];
                                    return NumberWheel(number: _counter~/10);
                                  })
                          ),
                          Flexible(
                              child: new StreamBuilder<DocumentSnapshot>(
                                  stream: crudProvider.fetchBusinessDocAsStream('test'),
                                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                                    if (!snapshot.hasData) {
                                      return NumberWheel(number: _counter%10);
                                    }
                                    _counter = snapshot.data.data()['count'];
                                    capacity = snapshot.data.data()['capacity'];
                                    return NumberWheel(number: _counter%10);
                                  })
                          ),
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
                        // TODO: show business name here if it has been saved in the settings page
                        child:
                      new StreamBuilder<DocumentSnapshot>(
                          stream: crudProvider.fetchBusinessDocAsStream('test'),
                          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Text("Capacity Counter");
                            }
                            name = snapshot.data.data()['name'];
                            return Text('To $name', style: TextStyle(fontSize: 20));
                          })
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

