import 'dart:io';
import 'package:flutter/material.dart';

import 'package:wintoast/wintoast.dart';


ToastService? service;

void main() {
  service = new ToastService(
    appName: 'wintoast.dart',
    companyName: 'alexmercerind',
    productName: 'wintoast_example',
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('wintoast.dart'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(32.0),
          children: [
            Container(
              height: 56.0,
              child: Row(
                children: [
                  Expanded(
                    child: Text('A toast with a subtitle.'),
                  ),
                  ElevatedButton(onPressed: () {
                    Toast toast = new Toast(
                      type: ToastType.text02,
                      title: 'Hello World!',
                      subtitle: 'This toast contains a subtitle.',
                    );
                    service?.show(toast);
                    toast.dispose();
                  }, child: Text('Show'))
                ],
              ),
            ),
            Container(
              height: 56.0,
              child: Row(
                children: [
                  Expanded(
                    child: Text('A toast with an image.'),
                  ),
                  ElevatedButton(onPressed: () {
                    Toast toast = new Toast(
                      type: ToastType.imageAndText02,
                      title: 'Hello World!',
                      subtitle: 'This toast contains an image.',
                      image: new File('C:/Windows/Web/Screen/img100.jpg')
                    );
                    service?.show(toast);
                    toast.dispose();
                  }, child: Text('Show'))
                ],
              ),
            ),
            Container(
              height: 56.0,
              child: Row(
                children: [
                  Expanded(
                    child: Text('A toast with actions.'),
                  ),
                  ElevatedButton(onPressed: () {
                    Toast toast = new Toast(
                      type: ToastType.imageAndText02,
                      title: 'Hello World!',
                      subtitle: 'This toast contains actions in it.',
                      image: new File('C:/Windows/Web/Screen/img100.jpg'),
                      actions: [
                        'Accept',
                        'Decline',
                      ]
                    );
                    service?.show(toast);
                    toast.dispose();
                  }, child: Text('Show'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}