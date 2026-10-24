import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MultipleStreamControllerPage extends StatefulWidget {
  MultipleStreamControllerPage({super.key});

  @override
  State<MultipleStreamControllerPage> createState() =>
      _MultipleStreamControllerPageState();
}

class _MultipleStreamControllerPageState
    extends State<MultipleStreamControllerPage> {
  StreamController<int> streamController1 = StreamController<int>();

  StreamController<int> streamController2 = StreamController<int>();

  StreamController<int> streamController3 = StreamController<int>.broadcast();

  int _counter1 = 0;

  int _counter2 = 0;

  int _counter3 = 0;

  void _incremetarStram1() {
    _counter1++;
    streamController1.sink.add(_counter1);
  }

  void _incremetarStram2() {
    _counter2++;
    streamController2.sink.add(_counter2);
  }

  void _incremetarStram3() {
    _counter3++;
    streamController3.sink.add(_counter3);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    streamController1.close();
    streamController2.close();
    streamController3.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("StreamController")),
      body: Center(
        child: Column(
          mainAxisSize: .min,
          children: [
            StreamBuilder(
              stream: streamController1.stream,
              initialData: _counter1,
              builder: (context, snapshot) {
                return Container(
                  child: Text(
                    "Stream1: ${snapshot.data}",
                    style: TextStyle(fontSize: 32),
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                _incremetarStram1();
              },
              child: Text("Incrementar stream 1"),
            ),
            StreamBuilder(
              stream: streamController2.stream,
              initialData: _counter2,
              builder: (context, snapshot) {
                return Container(
                  child: Text(
                    "Stream2: ${snapshot.data}",
                    style: TextStyle(fontSize: 32),
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                _incremetarStram2();
              },
              child: Text("Incrementar stream 2"),
            ),
            StreamBuilder(
              stream: streamController3.stream,
              initialData: _counter3,
              builder: (context, snapshot) {
                return Container(
                  child: Text(
                    "Stream3: ${snapshot.data}",
                    style: TextStyle(fontSize: 32),
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                _incremetarStram3();
              },
              child: Text("Incrementar stream 2"),
            ),
            Divider(),
            StreamBuilder(
              stream: streamController3.stream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Padding(
                  padding: EdgeInsetsGeometry.all(32),
                  child: LinearProgressIndicator(
                    value: (snapshot.data ?? 0) / 10,
                  ),
                );
              },
            ),
            StreamBuilder(
              stream: streamController3.stream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if ((snapshot.data ?? 0) >= 10) {
                  return Text("Stream 3 llego a 10!!!");
                }
                return Text("Progreso: ${snapshot.data ?? 0}/10");
              },
            ),
          ],
        ),
      ),
    );
  }
}
