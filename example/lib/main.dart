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
  void initState() { 
    super.initState();
    Toast toast = new Toast(
      type: ToastType.imageAndText02,
      title: 'Hello World!',
      subtitle: 'This toast is sent by wintoast.dart',
      image: new File('C:/Windows/Web/Screen/img100.jpg')
    );
    service?.show(toast);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('wintoast.dart'),
          centerTitle: true,
        ),
        body: Center(),
      ),
    );
  }
}