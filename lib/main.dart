import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.tealAccent,
        appBar: AppBar(
          centerTitle: true,
          title: Text('21'),
          backgroundColor: Colors.teal,
        ),
        body: DicePage(),
      ),
    );
  }
}

class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  @override
  int num = 0, st;
  double cur = 1.0, record = 0;
  String s;
  var time = new Stopwatch();

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('How it feels:'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(s),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void rebuild(int type) {
    cur = 1.0;
    num = 0;
    if (type == 0) _showMyDialog();
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Your current record is $record',
          style: TextStyle(fontSize: 20),
        ),
        Column(
          children: [
            Text(
              'Press + 22 times!',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Times New Roman',
              ),
            ),
            Opacity(
              opacity: cur,
              child: Text(
                '$num',
                style: TextStyle(
                  fontSize: 100,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            FlatButton(
              onPressed: () {
                num = num + 1;
                print(num);
                if (num == 1) {
                  time.start();
                  st = time.elapsedMilliseconds;
                }
                if (num == 23) {
                  s = 'U Lose :(. You pressed it $num times';
                  rebuild(0);
                }
                if (num == 10) cur = 0.5;
                if (num == 11) cur = 0;
                setState(() {});
              },
              child: Icon(
                Icons.add,
                size: 50,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  onPressed: () {
                    int ms = time.elapsedMilliseconds;
                    double sec = (ms - st) / 1000;
                    if (num == 22) {
                      if (record == 0)
                        record = sec;
                      else if (record > sec) record = sec;
                      s = 'U Win :) Time: $sec.';
                    } else
                      s = 'U Lose :( Time: $sec.';
                    s = s + '. You pressed it $num times';
                    rebuild(0);
                  },
                  child: Text(
                    'End',
                    style: TextStyle(fontSize: 50),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    rebuild(1);
                  },
                  child: Icon(
                    Icons.refresh,
                    size: 70,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
