import 'dart:io';
import 'package:desktoasts_cli/desktoasts_cli.dart';

ToastService? service;

Future main() async {
  service = ToastService(
    appName: 'desktoasts_cli',
    companyName: 'alexmercerind',
    productName: 'desktoasts_cli',
  );
  service?.stream.listen((event) {
    if (event is ToastDismissed) {
      print('Toast was dismissed.');
    }
    if (event is ToastActivated) {
      print('Toast was clicked.');
    }
    if (event is ToastInteracted) {
      print('${event.action} action in the toast was clicked.');
    }
  });
  service?.show(Toast(
    type: ToastType.imageAndText02,
    title: 'Hello!',
    subtitle: 'How are you?',
    image: File('C:/Windows/Web/Screen/img100.jpg'),
    actions: [
      'Good',
      'Bad'
    ],
  ));
  await Future.delayed(Duration(seconds: 10));
}
